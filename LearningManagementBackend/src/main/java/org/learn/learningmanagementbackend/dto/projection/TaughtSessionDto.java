package org.learn.learningmanagementbackend.dto.projection;

import java.time.LocalDate;

public interface TaughtSessionDto {

    Integer getScheduleId();
    Integer getClassId();
    LocalDate getSessionDate();
    Integer getSessionCount();

}
