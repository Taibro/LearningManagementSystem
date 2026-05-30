package org.learn.learningmanagementbackend.dto.request;

import lombok.Data;

@Data
public class CreateTenantRequest {

    private String schoolName;
    private String schoolCode;
    private String schoolType;
    private Integer planId;
    private String billingCycle;
    private String phone;
    private String adminName;
    private String adminEmail;
}
