package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ScheduleType;

import java.time.LocalDate;
import java.time.LocalTime;

@Getter
@Setter
public class ScheduleResponse {
    private Integer id;
    private Integer classId;
    private String classCode; // Assuming Classes has a classCode or name
    private Integer roomId;
    private String roomNumber;
    private String roomBuilding;
    private Integer dayOfWeek;
    private LocalTime startTime;
    private LocalTime endTime;
    private LocalDate startDate;
    private LocalDate endDate;
    private ScheduleType type;
    private String notes;
    private Integer startPeriod;
    private Integer endPeriod;
    private String teacherName;
}
