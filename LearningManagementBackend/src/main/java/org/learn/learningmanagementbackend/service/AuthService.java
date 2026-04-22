package org.learn.learningmanagementbackend.service;

import org.learn.learningmanagementbackend.dto.request.AuthRequest;
import org.learn.learningmanagementbackend.dto.response.UserProfileResponse;
import org.learn.learningmanagementbackend.model.Student;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.StudentRepository;
import org.learn.learningmanagementbackend.repository.TeacherRepository;
import org.learn.learningmanagementbackend.repository.UserRepository;
import org.learn.learningmanagementbackend.security.JWTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationManagerResolver;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JWTService jwtService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private TeacherRepository teacherRepository;

    public UserProfileResponse login(AuthRequest request){
        String combinedUsername = request.getUserType().toUpperCase() + ":" + request.getLoginCode();

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(combinedUsername, request.getPassword())
        );

        String token = jwtService.generateToken(combinedUsername);

        UserProfileResponse response = new UserProfileResponse();
        response.setToken(token);
        response.setRole(request.getUserType().toUpperCase());

        if ("STUDENT".equals(response.getRole())){
            Student student = studentRepository.findByStudentCode(request.getLoginCode()).get();
            response.setId(student.getUser().getId());
            response.setFullName(student.getUser().getFullName());
            response.setEmail(student.getUser().getEmail());
            response.setSpecificCode(student.getStudentCode());
        }else if ("TEACHER".equals(response.getRole())){
            Teacher teacher = teacherRepository.findByTeacherCode(request.getLoginCode()).get();
            response.setId(teacher.getUser().getId());
            response.setFullName(teacher.getUser().getFullName());
            response.setEmail(teacher.getUser().getEmail());
            response.setSpecificCode(teacher.getTeacherCode());
        }else{
            Users admin = userRepository.findByEmail(request.getLoginCode()).get();
            response.setId(admin.getId());
            response.setFullName(admin.getFullName());
            response.setEmail(admin.getEmail());
            response.setSpecificCode("ADMIN");
        }
        return response;
    }
}
