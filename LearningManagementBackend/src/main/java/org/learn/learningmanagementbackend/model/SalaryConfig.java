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
@Table(name = "Salary_config")
@NoArgsConstructor
@AllArgsConstructor
public class SalaryConfig extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "school_id", nullable = false)
    private School school;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "salary_grade_id", nullable = false)
    private SalaryGrade salaryGrade;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "base_salary", nullable = false)
    private BigDecimal baseSalary;

    @Column(name = "effective_from", nullable = false)
    private LocalDate effectiveFrom;

    @Column(name = "effective_to", nullable = true)
    private LocalDate effectiveTo;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "note")
    private String note;

    @OneToMany(mappedBy = "salaryConfig")
    private List<TeacherSalarySheet> salaryConfigs = new ArrayList<>();
}
