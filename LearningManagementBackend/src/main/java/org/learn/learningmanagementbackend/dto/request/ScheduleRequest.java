package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ScheduleType;

import java.time.LocalDate;
import java.time.LocalTime;

@Getter
@Setter
public class ScheduleRequest {

    @NotNull(message = "Class ID is required")
    private Integer classId;

    @NotNull(message = "Room ID is required")
    private Integer roomId;

    @NotNull(message = "Day of week is required")
    private Integer dayOfWeek;

    @NotNull(message = "Start time is required")
    private LocalTime startTime;

    @NotNull(message = "End time is required")
    private LocalTime endTime;

    @NotNull(message = "Start date is required")
    private LocalDate startDate;

    @NotNull(message = "End date is required")
    private LocalDate endDate;

    @NotNull(message = "Schedule type is required")
    private ScheduleType type;

    private String notes;
    private Integer startPeriod;
    private Integer endPeriod;
}
