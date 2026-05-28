package org.learn.learningmanagementbackend.security;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
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

        if ("STUDENT".equals(userType)) {
            Student student = studentRepository.findByStudentCode(loginCode)
                    .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy sinh viên"));
            user = student.getUser();
        } else if ("TEACHER".equals(userType)) {
            Teacher teacher = teacherRepository.findByTeacherCode(loginCode)
                    .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy giảng viên"));
            user = teacher.getUser();
        } else if ("ADMIN".equals(userType)) {
            user = userRepository.findByEmail(loginCode)
                    .orElseThrow(() -> new UsernameNotFoundException("Không tìm thấy admin"));
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
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + userType))
        );
    }
}
