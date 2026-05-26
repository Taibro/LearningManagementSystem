package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "Salary_grade")
@NoArgsConstructor
@AllArgsConstructor
public class SalaryGrade extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "school_id", nullable = false)
    private School school;

    @Column(name = "degree", nullable = false, length = 50)
    private String degree;

    @Column(name = "coefficient", nullable = false)
    private BigDecimal coefficient;

    @Column(name = "rate_per_session", nullable = false)
    private BigDecimal ratePerSession;

    @Column(name = "description")
    private String description;

    @Column(name = "effective_from", nullable = false)
    private LocalDate effectiveFrom;

    @Column(name = "effective_to", nullable = true)
    private LocalDate effectiveTo;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive;

    @OneToMany(mappedBy = "salaryGrade")
    private List<SalaryConfig> salaryConfigs = new ArrayList<>();

    @OneToMany(mappedBy = "salaryGrade")
    private List<TeacherSalarySheet> salarySheets = new ArrayList<>();
}
