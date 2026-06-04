package org.learn.learningmanagementbackend.dto.projection;

import java.time.LocalDate;
import java.time.LocalTime;

public interface StudentScheduleDto {

    String getCourseName();
    String getCourseCode();
    String getClassCode();
    String getRoomName();
    Integer getDayOfWeek();
    LocalTime getStartTime();
    LocalTime getEndTime();
    String getSessionType();
    Integer getStartPeriod();
    Integer getEndPeriod();
    LocalDate getStartDate();
    LocalDate getEndDate();
    String getTeacherName();
    Integer getCredits();
    String getExceptionType();
    String getSubstituteStatus();
    String getSubstituteTeacherName();
    String getMakeupStatus();
    LocalDate getExceptionDate();
    LocalDate getReplacementDate();
    Integer getReplacementStartPeriod();
    Integer getReplacementEndPeriod();
    String getReplacementRoomName();
}
