package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.enums.ExceptionType;
import org.learn.learningmanagementbackend.enums.MakeupStatus;

import java.time.LocalDate;

@Getter
@Setter
public class ScheduleExceptionResponse {
    private Integer id;
    private Integer scheduleId;
    private String scheduleDetails; // Ví dụ: "INT101 - Thứ 2"
    private LocalDate exceptionDate;
    private String reason;
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
    private String substituteTeacherName;
    private String substituteContent;
    private ApprovalStatus substituteStatus;
    private Integer replacementRoomId;
    private String replacementRoomNumber;
    private String adminNote;       // Lý do từ chối
    private String teacherCode;     // Mã giảng viên gửi đề xuất
    private String teacherName;     // Tên giảng viên
    private String classCode;       // Mã lớp học phần
    private String courseName;      // Tên môn học
}
