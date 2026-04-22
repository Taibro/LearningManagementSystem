package org.learn.learningmanagementbackend.dto.request;

import lombok.Data;

@Data
public class AuthRequest {

    private String loginCode;
    private String password;
    private String userType;

}
