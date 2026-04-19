package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "Class")
public class Classes extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "code", length = 30)
    private String code;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id")
    private Course course;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "semester_id")
    private Semester semester;

    @OneToMany(mappedBy = "courseClass", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ClassTeacher> teacherLecturings = new ArrayList<>();

    public void addTeacher(Teacher teacher, String role){
        ClassTeacher classTeacher = new ClassTeacher();
        classTeacher.setCourseClass(this);
        classTeacher.setTeacher(teacher);
        classTeacher.setRole(role);

        this.teacherLecturings.add(classTeacher);
    }

    @OneToMany(mappedBy = "classes", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Schedule> schedules = new ArrayList<>();

    @OneToMany(mappedBy = "classes", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Enrollment> enrollments = new ArrayList<>();
}
