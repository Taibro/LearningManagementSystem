package org.learn.learningmanagementbackend.dto.request;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class SaasPlanRequest {

    private String code;
    private String name;
    private BigDecimal monthlyPrice;
    private BigDecimal yearlyPrice;
    private Integer maxStudents;
    private Integer maxStorageGb;
    private String features;
    private Boolean isActive;
}
