package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.enums.ExceptionType;
import org.learn.learningmanagementbackend.enums.MakeupStatus;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "schedule_exceptions")
public class ScheduleException extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "schedule_id")
    private Schedule schedule;

    @Column(name = "exception_date")
    private LocalDate exceptionDate;

    @Column(name = "reason", length = 255)
    private String reason;

    @Enumerated(EnumType.STRING)
    @Column(name = "exception_type")
    private ExceptionType exceptionType;

    @Column(name = "replacement_date")
    private LocalDate replacementDate;

    @Enumerated(value = EnumType.STRING)
    @Column(name = "approval_status")
    private ApprovalStatus approvalStatus;

    @Column(name = "proof_file_url")
    private String ProofFileUrl;

    @Column(name = "replacement_start_period")
    private Integer replacementStartPeriod;

    @Column(name = "replacement_end_period")
    private Integer replacementEndPeriod;

    @Column(name = "suggested_room")
    private String suggestedRoom;

    @Column(name = "makeup_notes")
    private String makeupNotes;

    @Column(name = "makeup_status")
    @Enumerated(EnumType.STRING)
    private MakeupStatus makeupStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "substitute_teacher_id")
    private Teacher substituteTeacher;

    @Column(name = "substitute_content")
    private String substituteContent;

    @Enumerated(value = EnumType.STRING)
    @Column(name = "substitute_status")
    private ApprovalStatus substituteStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "replacement_room_id", referencedColumnName = "id")
    private Room replacementRoom;
}
