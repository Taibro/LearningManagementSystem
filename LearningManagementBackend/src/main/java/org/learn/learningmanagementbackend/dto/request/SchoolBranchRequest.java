package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SchoolBranchRequest {

    @NotNull(message = "School ID is required")
    private Integer schoolId;

    @NotBlank(message = "Branch code is required")
    private String code;

    @NotBlank(message = "Branch name is required")
    private String name;

    private String address;
    private String city;
    private String district;
    private String phone;
    private String email;
    private Boolean isMain;
    private Boolean isActive;
}
