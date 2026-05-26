package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.*;
import org.learn.learningmanagementbackend.enums.TeacherSalaryStatus;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "Teacher_salary_sheet")
@NoArgsConstructor
@AllArgsConstructor
public class TeacherSalarySheet extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teacher_id", nullable = false)
    private Teacher teacher;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "salary_config_id", nullable = false)
    private SalaryConfig salaryConfig;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "salary_grade_id", nullable = true)
    private SalaryGrade salaryGrade;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "semester_id", nullable = false)
    private Semester semester;

    @Column(name = "period_month", nullable = false)
    private Integer periodMonth;

    @Column(name = "period_year", nullable = false)
    private Integer periodYear;

    @Column(name = "degree_snapshot", nullable = false)
    private String degreeSnapshot;

    @Column(name = "coefficient_snapshot", nullable = false)
    private BigDecimal coefficientSnapshot;

    @Column(name = "base_salary_snapshot", nullable = false)
    private BigDecimal baseSalarySnapshot;

    @Column(name = "rate_snapshot")
    private BigDecimal rateSnapshot;

    @Column(name = "planned_sessions", nullable = false)
    private Integer plannedSessions;

    @Column(name = "actual_sessions", nullable = false)
    private Integer actualSessions;

    @Column(name = "base_amount", nullable = false)
    private BigDecimal baseAmount;

    @Column(name = "session_amount", nullable = false)
    private BigDecimal sessionAmount;

    @Column(name = "bonus_amount", nullable = false)
    private BigDecimal bonusAmount;

    @Column(name = "deduction_amount", nullable = false)
    private BigDecimal deductionAmount;

    @Column(name = "net_amount", nullable = false)
    private BigDecimal netAmount;

    @Enumerated(value = EnumType.STRING)
    @Column(name = "status", nullable = false)
    private TeacherSalaryStatus status;

    @Column(name = "payment_date", nullable = true)
    private LocalDate paymentDate;

    @Column(name = "text")
    private String text;

    @OneToMany(mappedBy = "teacherSalarySheet", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TeacherSalaryDetail> teacherSalaryDetails = new ArrayList<>();
}
