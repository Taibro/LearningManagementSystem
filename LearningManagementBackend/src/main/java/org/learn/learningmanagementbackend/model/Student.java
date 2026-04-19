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
@Table(name = "Student")
public class Student extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private Users user;

    @Column(name = "student_code", length = 20)
    private String studentCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id", referencedColumnName = "id")
    private Department department;

    @Column(name = "enrollment_year")
    private Integer enrollmentYear;

    @Column(name = "major", length = 100)
    private String major;

    @Column(name = "class_name", length = 50)
    private String className;

    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Enrollment> enrollments = new ArrayList<>();

    public void addEnrollment(Enrollment enrollment){
        this.enrollments.add(enrollment);
        enrollment.setStudent(this);
    }

    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<AttendanceRecord> attendanceRecords = new ArrayList<>();

    public void addAttendanceRecord(AttendanceRecord attendanceRecord){
        this.attendanceRecords.add(attendanceRecord);
        attendanceRecord.setStudent(this);
    }

    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TuitionInvoice> tuitionInvoices = new ArrayList<>();

    public void addTuitionInvoice(TuitionInvoice tuitionInvoice){
        this.tuitionInvoices.add(tuitionInvoice);
        tuitionInvoice.setStudent(this);
    }

    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<StudentSemesterSummary> studentSemesterSummaries = new ArrayList<>();

    public void addStudentSemesterSummary(StudentSemesterSummary studentSemesterSummary){
        this.studentSemesterSummaries.add(studentSemesterSummary);
        studentSemesterSummary.setStudent(this);
    }
}
