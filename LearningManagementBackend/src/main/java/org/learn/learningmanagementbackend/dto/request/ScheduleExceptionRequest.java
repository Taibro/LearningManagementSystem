package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.enums.ExceptionType;
import org.learn.learningmanagementbackend.enums.MakeupStatus;

import java.time.LocalDate;

@Getter
@Setter
public class ScheduleExceptionRequest {

    @NotNull(message = "Schedule ID is required")
    private Integer scheduleId;

    @NotNull(message = "Exception date is required")
    private LocalDate exceptionDate;

    private String reason;

    @NotNull(message = "Exception type is required")
    private ExceptionType exceptionType;

    private LocalDate replacementDate;
    private ApprovalStatus approvalStatus;
    private String proofFileUrl;
    private Integer replacementStartPeriod;
    private Integer replacementEndPeriod;
    private String suggestedRoom;
    private String makeupNotes;
    private MakeupStatus makeupStatus;
    private Integer substituteTeacherId;
    private String substituteContent;
    private ApprovalStatus substituteStatus;
    private Integer replacementRoomId;
}
