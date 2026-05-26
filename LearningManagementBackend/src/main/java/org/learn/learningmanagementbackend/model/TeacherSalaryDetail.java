package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.TeacherRole;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "Teacher_salary_detail")
@NoArgsConstructor
@AllArgsConstructor
public class TeacherSalaryDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sheet_id", nullable = false)
    private TeacherSalarySheet teacherSalarySheet;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teacher_id", nullable = false)
    private Teacher teacher;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "class_id", nullable = false)
    private Classes classes;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "schedule_id")
    private Schedule schedule;

    @Column(name = "session_date", nullable = false)
    private LocalDate sessionDate;

    @Column(name = "session_count", nullable = false)
    private Integer sessionCount;

    @Enumerated(value = EnumType.STRING)
    @Column(name = "teacher_role", nullable = false)
    private TeacherRole teacherRole;

    @Column(name = "rate_snapshot", nullable = false)
    private BigDecimal rateSnapshot;

    @Column(name = "amount", nullable = false)
    private BigDecimal amount;

    @Column(name = "note")
    private String note;
}
