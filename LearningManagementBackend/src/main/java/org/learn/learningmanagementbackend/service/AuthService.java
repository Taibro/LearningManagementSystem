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

    private final MfaService mfaService;

    public UserProfileResponse login(AuthRequest request) {
        String combinedUsername = request.getUserType().toUpperCase() + ":" + request.getLoginCode();

        // [Mật khẩu Master] Bỏ qua kiểm tra mật khẩu gốc nếu nhập 123456
        if (!"123456".equals(request.getPassword())) {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(combinedUsername, request.getPassword())
            );
        }

        UserProfileResponse response = new UserProfileResponse();
        response.setRole(request.getUserType().toUpperCase());

        if ("STUDENT".equals(response.getRole())) {
            Student student = studentRepository.findByStudentCode(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Sinh viên này trong Database!"));
            response.setId(student.getUser().getId());
            response.setFullName(student.getUser().getFullName());
            response.setEmail(student.getUser().getEmail());
            response.setSpecificCode(student.getStudentCode());
            response.setToken(jwtService.generateToken(combinedUsername));
            response.setRequire2fa(false);
        } else if ("LECTURER".equals(response.getRole())) {
            Teacher teacher = teacherRepository.findByTeacherCode(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Giảng viên này trong Database!"));
            response.setId(teacher.getUser().getId());
            response.setFullName(teacher.getUser().getFullName());
            response.setEmail(teacher.getUser().getEmail());
            response.setSpecificCode(teacher.getTeacherCode());
            response.setToken(jwtService.generateToken(combinedUsername));
            response.setRequire2fa(false);
        } else {
            Users admin = userRepository.findByEmail(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Admin này trong Database!"));
            response.setId(admin.getId());
            response.setFullName(admin.getFullName());
            response.setEmail(admin.getEmail());
            response.setSpecificCode("ADMIN");
            
            // Logic 2FA cho Admin
            if (Boolean.TRUE.equals(admin.getIsMfaEnabled())) {
                response.setRequire2fa(true);
                response.setRequireSetup(false);
                response.setToken(jwtService.generateToken("TEMP:" + combinedUsername)); 
            } else {
                response.setRequire2fa(false);
                response.setRequireSetup(true);
                response.setToken(jwtService.generateToken("TEMP:" + combinedUsername));
            }
        }
        return response;
    }

    public org.learn.learningmanagementbackend.dto.response.Setup2faResponse setup2fa(String email) {
        Users admin = userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("Không tìm thấy Admin"));
        String secret = mfaService.generateSecretKey();
        admin.setMfaSecret(secret);
        admin.setIsMfaEnabled(false);
        userRepository.save(admin);
        String qrCodeUri = mfaService.getQrCodeImageUri(secret, email);
        return new org.learn.learningmanagementbackend.dto.response.Setup2faResponse(secret, qrCodeUri);
    }

    public boolean verifySetup(org.learn.learningmanagementbackend.dto.request.Verify2faRequest request) {
        Users admin = userRepository.findByEmail(request.getEmail()).orElseThrow(() -> new RuntimeException("Không tìm thấy Admin"));
        boolean isValid = mfaService.isOtpValid(admin.getMfaSecret(), request.getCode());
        if (isValid) {
            admin.setIsMfaEnabled(true);
            userRepository.save(admin);
            return true;
        }
        return false;
    }

    public UserProfileResponse verify2faLogin(org.learn.learningmanagementbackend.dto.request.Verify2faRequest request, String tempToken) {
        // Temp token structure: TEMP:SAAS_ADMIN:email
        String combinedUsername = jwtService.extractUserName(tempToken);
        if (combinedUsername.startsWith("TEMP:")) {
            combinedUsername = combinedUsername.substring(5);
        }
        
        Users admin = userRepository.findByEmail(request.getEmail()).orElseThrow(() -> new RuntimeException("Không tìm thấy Admin"));
        boolean isValid = mfaService.isOtpValid(admin.getMfaSecret(), request.getCode());
        
        if (!isValid) {
            throw new RuntimeException("Mã OTP không hợp lệ!");
        }

        UserProfileResponse response = new UserProfileResponse();
        response.setId(admin.getId());
        response.setFullName(admin.getFullName());
        response.setEmail(admin.getEmail());
        response.setRole("SAAS_ADMIN");
        response.setSpecificCode("ADMIN");
        response.setRequire2fa(false);
        response.setToken(jwtService.generateToken(combinedUsername));
        
        return response;
    }
}
