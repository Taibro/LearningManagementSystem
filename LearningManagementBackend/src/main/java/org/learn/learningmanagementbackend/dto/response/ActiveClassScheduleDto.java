package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;
import java.util.List;

@Data
@Builder
public class ActiveClassScheduleDto {
    private Integer classId;
    private String classCode;
    private String courseName;
    private List<ScheduleDetail> schedules;

    @Data
    @Builder
    public static class ScheduleDetail {
        private Integer scheduleId;
        private Integer dayOfWeek;
        private Integer startPeriod;
        private Integer endPeriod;
        private String roomName;
    }
}
