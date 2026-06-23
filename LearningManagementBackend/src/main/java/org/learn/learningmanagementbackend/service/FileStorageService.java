package org.learn.learningmanagementbackend.service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.apache.tika.Tika;

import java.io.IOException;
import java.util.Map;
import java.util.Collections;

@Service
@RequiredArgsConstructor
@Slf4j
public class FileStorageService {

    private final Cloudinary cloudinary;

    public String uploadFileToCloud(MultipartFile file, String folderName) {
        try {

            Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap(
                    "resource_type", "auto",
                    "folder", folderName
            ));

            return uploadResult.get("secure_url").toString();

        } catch (IOException e) {
            log.error("Thất bại khi đẩy file lên hệ thống Cloudinary: ", e);
            throw new RuntimeException("Hệ thống không thể tải file lên đám mây. Vui lòng thử lại!");
        }
    }

    public void deleteFileFromCloud(String fileUrl) {
        try {
            if (fileUrl != null && fileUrl.contains("/")) {
                int uploadIndex = fileUrl.indexOf("upload/");
                if (uploadIndex != -1) {
                    String afterUpload = fileUrl.substring(uploadIndex + 7);
                    int versionEndIndex = afterUpload.indexOf('/');
                    if (versionEndIndex != -1) {
                        String fullPath = afterUpload.substring(versionEndIndex + 1);
                        int lastDotIndex = fullPath.lastIndexOf('.');
                        String publicId = (lastDotIndex != -1) ? fullPath.substring(0, lastDotIndex) : fullPath;
                        
                        Map result = cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
                        if (!"ok".equals(result.get("result"))) {
                            result = cloudinary.uploader().destroy(publicId, ObjectUtils.asMap("resource_type", "raw"));
                            if (!"ok".equals(result.get("result"))) {
                                cloudinary.uploader().destroy(publicId, ObjectUtils.asMap("resource_type", "video"));
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            log.error("Không thể xóa file từ Cloudinary: ", e);
        }
    }

    public Map getCloudinaryUsage() {
        try {
            return cloudinary.api().usage(ObjectUtils.emptyMap());
        } catch (Exception e) {
            log.error("Không thể lấy thông tin usage từ Cloudinary: ", e);
            return Collections.emptyMap();
        }
    }

    public void validateAcademicAndImageFiles(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new RuntimeException("Vui lòng chọn file tải lên!");
        }

        try {
            Tika tika = new Tika();
            String detectedType = tika.detect(file.getInputStream());

            boolean isValid = detectedType.equals("application/pdf") ||
                    detectedType.equals("application/msword") ||
                    detectedType.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document") ||
                    detectedType.equals("application/vnd.ms-excel") ||
                    detectedType.equals("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") ||
                    detectedType.equals("application/vnd.ms-powerpoint") ||
                    detectedType.equals("application/vnd.openxmlformats-officedocument.presentationml.presentation") ||
                    detectedType.equals("application/zip") ||
                    detectedType.equals("application/x-rar-compressed") ||
                    detectedType.equals("application/vnd.rar") ||
                    detectedType.equals("image/jpeg") ||
                    detectedType.equals("image/png") ||
                    detectedType.equals("video/mp4") ||
                    detectedType.equals("text/plain");

            if (!isValid) {
                throw new RuntimeException("Định dạng file không hợp lệ! Chỉ cho phép tải lên file học thuật (PDF, Word, Excel, PPT, TXT), file nén (ZIP, RAR), hình ảnh (JPG, PNG) hoặc video (MP4).");
            }
        } catch (IOException e) {
            throw new RuntimeException("Không thể phân tích định dạng file: " + e.getMessage());
        }
    }
}