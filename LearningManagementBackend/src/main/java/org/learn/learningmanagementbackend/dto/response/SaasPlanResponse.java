package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class SaasPlanResponse {

    private Integer id;
    private String code;
    private String name;
    private BigDecimal monthlyPrice;
    private BigDecimal yearlyPrice;
    private Integer maxStudents;
    private Integer maxStorageGb;
    private String features;
    private Boolean isActive;
    private long subscriberCount;
}
