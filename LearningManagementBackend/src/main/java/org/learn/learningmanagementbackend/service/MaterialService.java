package org.learn.learningmanagementbackend.service;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.MaterialResponse;
import org.learn.learningmanagementbackend.model.ClassMaterial;
import org.learn.learningmanagementbackend.repository.ClassMaterialRepository;
import org.learn.learningmanagementbackend.repository.ClassRepository;
import org.learn.learningmanagementbackend.repository.TeacherRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MaterialService {

    private final FileStorageService fileStorageService;
    private final ClassMaterialRepository materialRepository;
    private final ClassRepository classRepository;
    private final TeacherRepository teacherRepository;

    @Transactional(rollbackFor = Exception.class)
    public void uploadMaterial(Integer classId, Integer teacherId, String title, String docType, MultipartFile file) {

        String cloudFileUrl = fileStorageService.uploadFileToCloud(file);

        ClassMaterial material = new ClassMaterial();

        material.setClassObj(classRepository.getReferenceById(classId));
        material.setUploadedBy(teacherRepository.getReferenceById(teacherId));

        material.setTitle(title);
        material.setDocType(docType);
        material.setFileName(file.getOriginalFilename());
        material.setFileUrl(cloudFileUrl);
        material.setFileSize(file.getSize());
        material.setContentType(file.getContentType());

        materialRepository.save(material);
    }

    public List<MaterialResponse> getTeacherMaterials(Integer teacherId, Integer classId, String docType) {
        // Xử lý logic chuỗi rỗng từ bộ lọc Frontend truyền xuống
        String filterDocType = (docType != null && !docType.trim().isEmpty()) ? docType : null;

        List<ClassMaterial> materials = materialRepository.searchMaterials(teacherId, classId, filterDocType);

        return materials.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteMaterial(Integer materialId, Integer teacherId) {
        ClassMaterial material = materialRepository.findById(materialId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy tài liệu"));

        if (!material.getUploadedBy().getId().equals(teacherId)) {
            throw new RuntimeException("Bạn không có quyền xóa tài liệu này!");
        }

        materialRepository.delete(material);
    }

    private MaterialResponse mapToResponse(ClassMaterial material) {
        String classInfo = material.getClassObj().getCode();

        String formattedDate = (material.getCreatedAt() != null)
                ? material.getCreatedAt().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))
                : "N/A";

        return MaterialResponse.builder()
                .id(material.getId())
                .title(material.getTitle())
                .classInfo(classInfo)
                .fileSize(formatFileSize(material.getFileSize()))
                .uploadDate(formattedDate) // Dùng biến an toàn vừa tạo
                .fileUrl(material.getFileUrl())
                .docType(material.getDocType())
                .build();
    }

    private String formatFileSize(Long bytes) {
        if (bytes == null || bytes == 0) return "0 KB";
        if (bytes < 1024 * 1024) {
            return (bytes / 1024) + " KB";
        }
        return String.format("%.1f MB", (double) bytes / (1024 * 1024));
    }

    public ClassMaterial getMaterialById(Integer materialId) {
        return materialRepository.findById(materialId)
                .orElseThrow(() -> new RuntimeException("Tài liệu không tồn tại hoặc đã bị xóa!"));
    }
}