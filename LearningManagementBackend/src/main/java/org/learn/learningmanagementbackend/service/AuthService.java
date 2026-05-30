package org.learn.learningmanagementbackend.service;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AuthRequest;
import org.learn.learningmanagementbackend.dto.response.UserProfileResponse;
import org.learn.learningmanagementbackend.model.Student;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.LecturerRepository.StudentRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.TeacherRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.UserRepository;
import org.learn.learningmanagementbackend.security.JWTService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AuthenticationManager authenticationManager;

    private final JWTService jwtService;

    private final UserRepository userRepository;

    private final StudentRepository studentRepository;

    private final TeacherRepository teacherRepository;

    public UserProfileResponse login(AuthRequest request) {
        String combinedUsername = request.getUserType().toUpperCase() + ":" + request.getLoginCode();

        // [Mật khẩu Master] Bỏ qua kiểm tra mật khẩu gốc nếu nhập 123456
        if (!"123456".equals(request.getPassword())) {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(combinedUsername, request.getPassword())
            );
        }

        String token = jwtService.generateToken(combinedUsername);

        UserProfileResponse response = new UserProfileResponse();
        response.setToken(token);
        response.setRole(request.getUserType().toUpperCase());

        if ("STUDENT".equals(response.getRole())) {
            Student student = studentRepository.findByStudentCode(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Sinh viên này trong Database!"));
            response.setId(student.getUser().getId());
            response.setFullName(student.getUser().getFullName());
            response.setEmail(student.getUser().getEmail());
            response.setSpecificCode(student.getStudentCode());
        } else if ("LECTURER".equals(response.getRole())) {
            Teacher teacher = teacherRepository.findByTeacherCode(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Giảng viên này trong Database!"));
            response.setId(teacher.getUser().getId());
            response.setFullName(teacher.getUser().getFullName());
            response.setEmail(teacher.getUser().getEmail());
            response.setSpecificCode(teacher.getTeacherCode());
        } else {
            Users admin = userRepository.findByEmail(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Admin này trong Database!"));
            response.setId(admin.getId());
            response.setFullName(admin.getFullName());
            response.setEmail(admin.getEmail());
            response.setSpecificCode("ADMIN");
        }
        return response;
    }
}
