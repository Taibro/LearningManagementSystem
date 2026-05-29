package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "courses")
public class Course extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "code", length = 20)
    private String code;

    @Column(name = "name", length = 150)
    private String name;

    @Column(name = "credits")
    private Integer credits;

    @Column(name = "theory_sessions", nullable = false)
    @ColumnDefault("30")
    private Integer theorySessions = 30;

    @Column(name = "practical_sessions", nullable = false)
    @ColumnDefault("0")
    private Integer practicalSessions = 0;

    @Column(name = "total_sessions")
    private Integer totalSessions = theorySessions + practicalSessions;

    @Column(name = "description")
    private String description;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "prerequisites", columnDefinition = "json")
    private List<Integer> prerequisites;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id")
    private Department department;

    @Column(name = "is_active")
    private Boolean isActive;

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Classes> classes = new ArrayList<>();

    @OneToMany(mappedBy = "primaryTeachingCourse", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Teacher> teachers = new ArrayList<>();

    public void addClass(Classes clazz) {
        this.classes.add(clazz);
        clazz.setCourse(this);
    }
    public void removeClass(Classes clazz) {
        this.classes.remove(clazz);
        clazz.setCourse(null);
    }
}
