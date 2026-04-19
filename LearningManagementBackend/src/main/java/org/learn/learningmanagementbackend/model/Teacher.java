package org.learn.learningmanagementbackend.model;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "Teacher")
public class Teacher extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "id", unique = true)
    private Users user;

    @Column(name = "teacher_code")
    private String teacherCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id", referencedColumnName = "id")
    private Department department;

    @Column(name = "degree", length = 50)
    private String degree;

    @Column(name = "specialization", length = 150)
    private String specialization;

    @Column(name = "join_date")
    private LocalDate joinedDate;

    @Column(name = "bio")
    private String bio;

    @OneToMany(mappedBy = "teacher", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ClassTeacher> classAssignments = new ArrayList<>();

//    public void addClass(Classes courseClass, String role){
//        ClassTeacher classTeacher = new ClassTeacher();
//        classTeacher.setTeacher(this);
//        classTeacher.setCourseClass(courseClass);
//        classTeacher.setRole(role);
//
//        this.classAssignments.add(classTeacher);
//    }
}
