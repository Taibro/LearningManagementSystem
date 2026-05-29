package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.Gender;

@Getter
@Setter
public class StudentResponse {
    private Integer id;
    private Integer userId;
    private String fullName;
    private String email;
    private Gender gender;
    private String studentCode;
    private Integer departmentId;
    private String departmentName;
    private Integer enrollmentYear;
    private String major;
    private String className;
}
