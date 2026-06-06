package org.learn.learningmanagementbackend.dto.response;

import lombok.Data;

@Data
public class UserProfileMobileResponse {

    private Integer id;
    private String fullName;
    private String email;
    private String specificCode;
    private String role;
    private String token;
    private Integer schoolId;

    // Mobile response có thể bỏ qua các trường không cần thiết như require2fa, requireSetup
    // vì Mobile app có luồng riêng không dùng Authenticator
}
