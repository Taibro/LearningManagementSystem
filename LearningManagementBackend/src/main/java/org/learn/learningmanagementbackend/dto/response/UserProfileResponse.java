package org.learn.learningmanagementbackend.dto.response;

import lombok.Data;

@Data
public class UserProfileResponse {

    private Integer id;
    private String fullName;
    private String email;
    private String specificCode;
    private String role;
    private String token;
    private Boolean require2fa;
    private Boolean requireSetup;
    private Integer schoolId;

}
