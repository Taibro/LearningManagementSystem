package org.learn.learningmanagementbackend.dto.projection;

import java.time.LocalDate;

public interface TeacherProfileDto {

    String getFullName();
    LocalDate getDateOfBirth();
    org.learn.learningmanagementbackend.enums.Gender getGender();
    String getEmail();
    String getPhone();
    String getAvatarUrl();
    String getTeacherCode();
    String getDegree();
    String getSpecialization();
    String getDepartmentName();
    String getCitizenIdNumber();
    String getAddress();
    String getPrimaryTeachingCourse();
}
