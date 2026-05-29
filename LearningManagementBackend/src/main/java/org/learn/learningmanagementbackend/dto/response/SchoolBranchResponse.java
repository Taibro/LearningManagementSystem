package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SchoolBranchResponse {
    private Integer id;
    private Integer schoolId;
    private String schoolName;
    private String code;
    private String name;
    private String address;
    private String city;
    private String district;
    private String phone;
    private String email;
    private Boolean isMain;
    private Boolean isActive;
}
