package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ApprovalStatus;
import org.learn.learningmanagementbackend.enums.ExceptionType;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "Schedule_exception")
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

    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "replacement_room_id", referencedColumnName = "id")
    private Room replacementRoom;
}
