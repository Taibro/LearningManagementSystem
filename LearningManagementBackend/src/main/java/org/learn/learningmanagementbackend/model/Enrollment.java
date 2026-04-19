package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.UpdateTimestamp;
import org.learn.learningmanagementbackend.enums.EnrollmentStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "Enrollment")
public class Enrollment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "class_id", nullable = false)
    private Classes classes;

    @Column(name = "enrollment_date")
    private LocalDateTime enrollmentDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private EnrollmentStatus status;

    @Column(name = "grade_midterm")
    private BigDecimal gradeMidterm;

    @Column(name = "grade_final")
    private BigDecimal gradeFinal;

    @Column(name = "grade_total")
    private BigDecimal gradeTotal;

    @Column(name = "grade_letter")
    private String gradeLetter;

    @Column(name = "dropped_at")
    private LocalDateTime droppedAt;

    @Column(name = "drop_reason", length = 255)
    private String dropReason;

    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by", referencedColumnName = "id")
    private Users createdBy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "updated_by", referencedColumnName = "id")
    private Users updatedBy;
}
