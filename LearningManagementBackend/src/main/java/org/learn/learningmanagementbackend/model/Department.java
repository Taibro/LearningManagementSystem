package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "Department")
@NoArgsConstructor
@AllArgsConstructor
public class Department extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    private School school;

    @Column(name = "code", length = 20)
    private String code;

    @Column(name = "name", length = 100)
    private String name;

    @Column(name = "description")
    private String description;

    @OneToMany(mappedBy = "department", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    private List<Teacher> teachers = new ArrayList<>();

    @OneToMany(mappedBy = "department", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    private List<Student> students = new ArrayList<>();

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Course> courses = new ArrayList<>();

    public void addTeacher(Teacher teacher) {
        this.teachers.add(teacher);
        teacher.setDepartment(this);
    }
    public void removeTeacher(Teacher teacher) {
        this.teachers.remove(teacher);
        teacher.setDepartment(null);
    }

    public void addStudent(Student student) {
        this.students.add(student);
        student.setDepartment(this);
    }
    public void removeStudent(Student student) {
        this.students.remove(student);
        student.setDepartment(null);
    }

    public void addCourse(Course course) {
        this.courses.add(course);
        course.setDepartment(this);
    }
    public void removeCourse(Course course) {
        this.courses.remove(course);
        course.setDepartment(null);
    }
}
