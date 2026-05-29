package org.learn.learningmanagementbackend.service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

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
}