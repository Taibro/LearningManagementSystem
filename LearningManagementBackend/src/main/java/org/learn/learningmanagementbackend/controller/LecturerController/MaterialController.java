package org.learn.learningmanagementbackend.controller.LecturerController;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.MaterialUploadRequest;
import org.learn.learningmanagementbackend.dto.response.MaterialResponse;
import org.learn.learningmanagementbackend.model.ClassMaterial;
import org.learn.learningmanagementbackend.service.LecturerService.MaterialService;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

@RestController
@RequestMapping("/api/lecturer/materials")
@RequiredArgsConstructor
public class MaterialController {

    private final MaterialService materialService;

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE, path = "upload")
    public ResponseEntity<String> uploadFile(@Valid @ModelAttribute MaterialUploadRequest request) {

        if (request.getFile().isEmpty()) {
            return ResponseEntity.badRequest().body("Tệp tin đính kèm đang bị rỗng!");
        }

        materialService.uploadMaterial(
                request.getClassId(),
                request.getTeacherId(),
                request.getTitle(),
                request.getDocType(),
                request.getFile(),
                request.getUploadDate()
        );

        return ResponseEntity.ok("Tài liệu đã được tải lên và đồng bộ đám mây thành công!");
    }

    @GetMapping
    public ResponseEntity<List<MaterialResponse>> getMaterials(
            @RequestParam("teacherId") Integer teacherId,
            @RequestParam(value = "classId", required = false) Integer classId,
            @RequestParam(value = "docType", required = false) String docType) {

        List<MaterialResponse> materials = materialService.getTeacherMaterials(teacherId, classId, docType);
        return ResponseEntity.ok(materials);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteMaterial(
            @PathVariable("id") Integer materialId,
            @RequestParam("teacherId") Integer teacherId) {

        materialService.deleteMaterial(materialId, teacherId);
        return ResponseEntity.ok("Đã xóa tài liệu thành công!");
    }

    @GetMapping("/{id}/view")
    public ResponseEntity<Resource> viewMaterial(@PathVariable("id") Integer id) throws IOException {
        ClassMaterial material = materialService.getMaterialById(id);

        // Mở kết nối ngầm tới Cloudinary
        URL url = new URL(material.getFileUrl());
        URLConnection connection = url.openConnection();
        InputStreamResource resource = new InputStreamResource(connection.getInputStream());

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + material.getFileName() + "\"")
                .contentType(MediaType.parseMediaType(material.getContentType()))
                .contentLength(material.getFileSize())
                .body(resource);
    }

    @GetMapping("/{id}/download")
    public ResponseEntity<Resource> downloadMaterial(@PathVariable("id") Integer id) throws IOException {
        ClassMaterial material = materialService.getMaterialById(id);

        URL url = new URL(material.getFileUrl());
        URLConnection connection = url.openConnection();
        InputStreamResource resource = new InputStreamResource(connection.getInputStream());

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + material.getFileName() + "\"")
                .contentType(MediaType.parseMediaType(material.getContentType()))
                .contentLength(material.getFileSize())
                .body(resource);
    }
}