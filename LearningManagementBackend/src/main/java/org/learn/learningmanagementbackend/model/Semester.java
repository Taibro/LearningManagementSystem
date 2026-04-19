package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Setter
@Getter
@Entity
@Table(name = "Semester")
public class Semester extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "academic_year_id")
    private AcademicYear academicYear;

    @Column(name = "name")
    private String name;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @Column(name = "is_active")
    private Boolean isActive;

    @OneToMany(mappedBy = "semester", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TuitionInvoice> tuitionInvoices = new ArrayList<>();

    public void addTuitionInvoice(TuitionInvoice tuitionInvoice){
        this.tuitionInvoices.add(tuitionInvoice);
        tuitionInvoice.setSemester(this);
    }

    @OneToMany(mappedBy = "semester", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<StudentSemesterSummary> studentSemesterSummaries = new ArrayList<>();

    public void addStudentSemesterSummary(StudentSemesterSummary studentSemesterSummary){
        this.studentSemesterSummaries.add(studentSemesterSummary);
        studentSemesterSummary.setSemester(this);
    }
}
