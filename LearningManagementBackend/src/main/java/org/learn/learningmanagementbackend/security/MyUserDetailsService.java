package org.learn.learningmanagementbackend.security;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.model.Role;
import org.learn.learningmanagementbackend.model.Student;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.LecturerRepository.StudentRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.TeacherRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.UserRepository;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MyUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;
    private final StudentRepository studentRepository;
    private final TeacherRepository teacherRepository;

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String combinedUsername) throws UsernameNotFoundException {
        String[] parts = combinedUsername.split(":");
        if (parts.length != 2) throw new UsernameNotFoundException("Dữ liệu đăng nhập không hợp lệ");

        String userType = parts[0];
        String loginCode = parts[1];
        Users user = null;

        String assignedRole = "";

        // Xử lý nhánh lấy User dựa vào Role
        if ("STUDENT".equals(userType)) {
            Student student = studentRepository.findByStudentCodeOrEmail(loginCode)
                    .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy sinh viên"));
            user = student.getUser();
            assignedRole = "ROLE_STUDENT";

        } else if ("LECTURER".equals(userType)) {
            Teacher teacher = teacherRepository.findByTeacherCode(loginCode)
                    .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy giảng viên"));
            user = teacher.getUser();
            assignedRole = "ROLE_LECTURER";

        } else if ("SCHOOL_ADMIN".equals(userType) || "SAAS_ADMIN".equals(userType)) {
            user = userRepository.findByEmail(loginCode)
                    .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy admin"));

            // Lấy danh sách tên quyền thực sự của user này từ Database
            List<String> actualRoles = user.getRoles().stream()
                    .map(Role::getName)
                    .toList();

            // Chặn đứng hành vi gian lận
            if ("SAAS_ADMIN".equals(userType) && !actualRoles.contains("SAAS_ADMIN")) {
                throw new RuntimeException("Cảnh báo bảo mật: Tài khoản của bạn không có quyền Quản trị hệ thống (SaaS)!");
            }
            if ("SCHOOL_ADMIN".equals(userType) && !actualRoles.contains("SCHOOL_ADMIN")) {
                throw new RuntimeException("Cảnh báo bảo mật: Tài khoản của bạn không có quyền Quản trị viên Trường!");
            }

            assignedRole = "ROLE_" + userType;

        } else {
            throw new UsernameNotFoundException("Loại tài khoản không hợp lệ");
        }

        return new CustomUserDetails(
                user.getId(),
                user.getFullName(),
                user.getEmail(),
                loginCode,
                combinedUsername,
                user.getPasswordHash(),
                Collections.singletonList(new SimpleGrantedAuthority(assignedRole))
        );
    }
}
