package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "teacher_evaluations")
public class TeacherEvaluation extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teacher_id", nullable = false)
    private Teacher teacher;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "semester_id", nullable = false)
    private Semester semester;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "class_id", nullable = false)
    private Classes classes;

    @Column(name = "score_knowledge")
    private Double scoreKnowledge;

    @Column(name = "score_method")
    private Double scoreMethod;

    @Column(name = "score_interaction")
    private Double scoreInteraction;

    @Column(name = "score_materials")
    private Double scoreMaterials;

    @Column(name = "score_punctuality")
    private Double scorePunctuality;

    @Column(name = "comment", columnDefinition = "TEXT")
    private String comment;

}