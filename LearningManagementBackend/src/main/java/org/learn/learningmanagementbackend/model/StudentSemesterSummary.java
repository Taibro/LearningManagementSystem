package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "Student_semester_summary", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"student_id", "semester_id"})
})
public class StudentSemesterSummary extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "semester_id", nullable = false)
    private Semester semester;

    @Column(name = "gpa")
    private BigDecimal gpa;

    @Column(name = "credits_earned")
    private Integer creditsEarned;

    @Column(name = "conduct_score")
    private Integer conductScore;

    @Column(name = "conduct_grade", length = 20)
    private String conductGrade;

    @Column(name = "scholarship_name", length = 150)
    private String scholarshipName;

    @Column(name = "scholarship_amount")
    private BigDecimal scholarshipAmount;

    @Column(name = "notes")
    private String notes;
}
