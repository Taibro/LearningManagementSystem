package org.learn.learningmanagementbackend.dto.projection;

public interface ClassProgressDto {

    Integer getClassId();
    String getCourseName();
    String getCourseCode();
    String getClassCode();
    String getClassStatus();
    Integer getTotalPeriods();
    Integer getTaughtPeriods();

}
