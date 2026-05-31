package org.learn.learningmanagementbackend.dto.request;

import lombok.Data;

@Data
public class Verify2faRequest {
    private String email;
    private String code;
}
