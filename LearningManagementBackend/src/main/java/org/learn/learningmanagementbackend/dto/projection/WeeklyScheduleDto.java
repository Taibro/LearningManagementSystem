package org.learn.learningmanagementbackend.dto.projection;

import java.time.LocalTime;

public interface WeeklyScheduleDto {

    String getCourseName();
    String getClassCode();
    String getRoomName();
    Integer getDayOfWeek();
    LocalTime getStartTime();
    LocalTime getEndTime();
    String getSessionType();
    Integer getStartPeriod();
    Integer getEndPeriod();
}
