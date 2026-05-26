package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "teacher_declarations")
@NoArgsConstructor
@AllArgsConstructor
public class TeacherDeclaration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teacher_id", nullable = false)
    private Teacher teacher;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "semester_id", nullable = false)
    private Semester semester;

    @Column(name = "expected_sessions", nullable = false)
    private Integer expectedSessions;

    @Column(name = "expected_classes", nullable = false)
    private Integer expectedClasses;

    @Column(name = "notes")
    private String notes;
}