package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LecturerProfileResponse {
    private String fullName;
    private String email;
    private String departmentName;
    private String phone;
    private String avatarUrl;
}