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

        // Kích hoạt Spring Security kiểm tra mật khẩu
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(combinedUsername, request.getPassword())
        );

        if (!"SAAS_ADMIN".equals(request.getUserType().toUpperCase())) {
            if (request.getSchool() == null || request.getSchool().trim().isEmpty()) {
                throw new RuntimeException("Vui lòng chọn trường học!");
            }
        }

        UserProfileResponse response = new UserProfileResponse();
        response.setRole(request.getUserType().toUpperCase());

        if ("STUDENT".equals(response.getRole())) {
            Student student = studentRepository.findByStudentCode(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Sinh viên này trong Database!"));
            if (!request.getSchool().equalsIgnoreCase(student.getUser().getSchool().getCode())) {
                throw new RuntimeException("Tài khoản không thuộc trường học đã chọn!");
            }
            response.setId(student.getUser().getId());
            response.setFullName(student.getUser().getFullName());
            response.setEmail(student.getUser().getEmail());
            response.setSpecificCode(student.getStudentCode());
            response.setToken(jwtService.generateToken(combinedUsername));
            response.setRequire2fa(false);
        } else if ("LECTURER".equals(response.getRole())) {
            Teacher teacher = teacherRepository.findByTeacherCode(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Giảng viên này trong Database!"));
            if (!request.getSchool().equalsIgnoreCase(teacher.getUser().getSchool().getCode())) {
                throw new RuntimeException("Tài khoản không thuộc trường học đã chọn!");
            }
            response.setId(teacher.getUser().getId());
            response.setFullName(teacher.getUser().getFullName());
            response.setEmail(teacher.getUser().getEmail());
            response.setSpecificCode(teacher.getTeacherCode());
            response.setToken(jwtService.generateToken(combinedUsername));
            response.setRequire2fa(false);
        } else {
            Users admin = userRepository.findByEmail(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Admin này trong Database!"));
            if (!"SAAS_ADMIN".equals(response.getRole())) {
                if (admin.getSchool() == null || !request.getSchool().equalsIgnoreCase(admin.getSchool().getCode())) {
                    throw new RuntimeException("Tài khoản không thuộc trường học đã chọn!");
                }
            }
            response.setId(admin.getId());
            response.setFullName(admin.getFullName());
            response.setEmail(admin.getEmail());
            response.setSpecificCode("ADMIN");
            if (admin.getSchool() != null) {
                response.setSchoolId(admin.getSchool().getId());
            }

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

        String userType = combinedUsername.split(":")[0];
        response.setRole(userType);

        response.setSpecificCode("ADMIN");
        if ("SCHOOL_ADMIN".equals(userType)) {
            response.setSchoolId(admin.getSchool() != null ? admin.getSchool().getId() : null);
        }

        response.setRequire2fa(false);
        response.setToken(jwtService.generateToken(combinedUsername));

        return response;
    }

    public org.learn.learningmanagementbackend.dto.response.UserProfileMobileResponse mobileLogin(AuthRequest request) {
        String combinedUsername = request.getUserType().toUpperCase() + ":" + request.getLoginCode();

        System.out.println("====== DEBUG LOGIN ======");
        System.out.println("combinedUsername: " + combinedUsername);
        System.out.println("Raw password entered: " + request.getPassword());
        try {
            Users testUser = null;
            if ("STUDENT".equalsIgnoreCase(request.getUserType())) {
                org.learn.learningmanagementbackend.model.Student s = studentRepository.findByStudentCode(request.getLoginCode()).orElse(null);
                if (s != null) testUser = s.getUser();
            } else if ("SCHOOL_ADMIN".equalsIgnoreCase(request.getUserType())) {
                testUser = userRepository.findByEmail(request.getLoginCode()).orElse(null);
            }
            if (testUser != null) {
                System.out.println("User found in DB!");
                System.out.println("Hash in DB: " + testUser.getPasswordHash());
                org.springframework.security.crypto.password.PasswordEncoder pe = new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder();
                boolean matches = pe.matches(request.getPassword(), testUser.getPasswordHash());
                System.out.println("Password match result: " + matches);
            } else {
                System.out.println("USER NOT FOUND IN DB before auth manager!");
            }
        } catch (Exception e) {
            System.out.println("Error in debug block: " + e.getMessage());
        }
        System.out.println("=========================");

        // Kích hoạt Spring Security kiểm tra mật khẩu
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(combinedUsername, request.getPassword())
        );

        if (!"SAAS_ADMIN".equals(request.getUserType().toUpperCase())) {
            if (request.getSchool() == null || request.getSchool().trim().isEmpty()) {
                throw new RuntimeException("Vui lòng chọn trường học!");
            }
        }

        org.learn.learningmanagementbackend.dto.response.UserProfileMobileResponse response = new org.learn.learningmanagementbackend.dto.response.UserProfileMobileResponse();
        response.setRole(request.getUserType().toUpperCase());

        if ("STUDENT".equals(response.getRole())) {
            Student student = studentRepository.findByStudentCode(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Sinh viên này trong Database!"));
            if (!request.getSchool().equalsIgnoreCase(student.getUser().getSchool().getCode())) {
                throw new RuntimeException("Tài khoản không thuộc trường học đã chọn!");
            }
            response.setId(student.getUser().getId());
            response.setFullName(student.getUser().getFullName());
            response.setEmail(student.getUser().getEmail());
            response.setSpecificCode(student.getStudentCode());
            response.setToken(jwtService.generateToken(combinedUsername));
        } else if ("LECTURER".equals(response.getRole())) {
            Teacher teacher = teacherRepository.findByTeacherCode(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Giảng viên này trong Database!"));
            if (!request.getSchool().equalsIgnoreCase(teacher.getUser().getSchool().getCode())) {
                throw new RuntimeException("Tài khoản không thuộc trường học đã chọn!");
            }
            response.setId(teacher.getUser().getId());
            response.setFullName(teacher.getUser().getFullName());
            response.setEmail(teacher.getUser().getEmail());
            response.setSpecificCode(teacher.getTeacherCode());
            response.setToken(jwtService.generateToken(combinedUsername));
        } else {
            Users admin = userRepository.findByEmail(request.getLoginCode()).orElseThrow(() -> new RuntimeException("Không tìm thấy Admin này trong Database!"));
            if (!"SAAS_ADMIN".equals(response.getRole())) {
                if (admin.getSchool() == null || !request.getSchool().equalsIgnoreCase(admin.getSchool().getCode())) {
                    throw new RuntimeException("Tài khoản không thuộc trường học đã chọn!");
                }
            }
            response.setId(admin.getId());
            response.setFullName(admin.getFullName());
            response.setEmail(admin.getEmail());
            response.setSpecificCode("ADMIN");
            if (admin.getSchool() != null) {
                response.setSchoolId(admin.getSchool().getId());
            }

            // Logic cho Mobile Admin: KHÔNG cần 2FA, trả về token thật luôn
            response.setToken(jwtService.generateToken(combinedUsername));
        }
        return response;
    }

}
