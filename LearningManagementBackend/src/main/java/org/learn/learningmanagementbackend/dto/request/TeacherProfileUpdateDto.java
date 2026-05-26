package org.learn.learningmanagementbackend.dto.request;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class TeacherProfileUpdateDto {

    private String fullName;
    private LocalDate dateOfBirth;
    private String gender;
    private String phone;
    private String citizenIdNumber;
    private String address;

    private String degree;
    private String specialization;

}
