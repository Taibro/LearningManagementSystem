package org.learn.learningmanagementbackend.dto.projection;

import java.time.LocalDate;

public interface StudentProfileDto {

    // Thông tin học vấn
    String getStudentCode();
    String getClassName();
    String getMajor();
    Integer getEnrollmentYear();
    String getDepartmentName();

    // Thông tin cá nhân (từ Users)
    String getFullName();
    LocalDate getDateOfBirth();
    org.learn.learningmanagementbackend.enums.Gender getGender();
    String getEmail();
    String getPhone();
    String getAddress();
    String getCitizenIdNumber();
    String getAvatarUrl();
}
