package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StudentRequest {

    @NotNull(message = "User ID is required")
    private Integer userId;

    private String studentCode;
    private Integer departmentId;
    private Integer enrollmentYear;
    private String major;
    private String className;
}
