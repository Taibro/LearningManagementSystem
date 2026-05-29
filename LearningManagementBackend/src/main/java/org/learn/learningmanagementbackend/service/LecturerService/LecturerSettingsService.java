package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.ChangePasswordRequest;
import org.learn.learningmanagementbackend.dto.request.UpdateProfileRequest;
import org.learn.learningmanagementbackend.dto.response.LecturerProfileResponse;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.LecturerRepository.TeacherRepository;
import org.learn.learningmanagementbackend.service.FileStorageService;
import org.learn.learningmanagementbackend.utils.AppConstants;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
@RequiredArgsConstructor
public class LecturerSettingsService {

    private final TeacherRepository teacherRepository;
    private final PasswordEncoder passwordEncoder;
    private final FileStorageService fileStorageService;

    // Lấy thông tin cá nhân đổ ra form
    public LecturerProfileResponse getProfile(String teacherCode) {
        Teacher teacher = teacherRepository.findByTeacherCode(teacherCode)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông tin giảng viên"));

        Users user = teacher.getUser();
        return LecturerProfileResponse.builder()
                .fullName(user.getFullName())
                .email(user.getEmail())
                .departmentName(teacher.getDepartment() != null ? teacher.getDepartment().getName() : "Chưa cập nhật")
                .phone(user.getPhone())
                .avatarUrl(user.getAvatarUrl())
                .build();
    }

    // Cập nhật số điện thoại
    @Transactional(rollbackFor = Exception.class)
    public void updateProfile(String teacherCode, UpdateProfileRequest request) {
        Teacher teacher = teacherRepository.findByTeacherCode(teacherCode)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông tin giảng viên"));

        teacher.getUser().setPhone(request.getPhone());
        teacherRepository.save(teacher);
    }

    // Đổi mật khẩu
    @Transactional(rollbackFor = Exception.class)
    public void changePassword(String teacherCode, ChangePasswordRequest request) {
        Teacher teacher = teacherRepository.findByTeacherCode(teacherCode)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông tin giảng viên"));
        Users user = teacher.getUser();

        // Kiểm tra mật khẩu cũ có khớp không
        if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPasswordHash())) {
            throw new RuntimeException("Mật khẩu hiện tại không chính xác!");
        }

        // Kiểm tra xác nhận mật khẩu mới
        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw new RuntimeException("Xác nhận mật khẩu mới không khớp!");
        }

        // Hash mật khẩu mới và lưu
        user.setPasswordHash(passwordEncoder.encode(request.getNewPassword()));
        teacherRepository.save(teacher);
    }

    // Đổi ảnh đại diện
    @Transactional(rollbackFor = Exception.class)
    public String updateAvatar(String teacherCode, MultipartFile avatarFile) {
        Teacher teacher = teacherRepository.findByTeacherCode(teacherCode)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông tin giảng viên"));
        
        String avatarUrl = fileStorageService.uploadFileToCloud(avatarFile, AppConstants.FOLDER_AVATARS);
        teacher.getUser().setAvatarUrl(avatarUrl);
        teacherRepository.save(teacher);
        return avatarUrl;
    }
}