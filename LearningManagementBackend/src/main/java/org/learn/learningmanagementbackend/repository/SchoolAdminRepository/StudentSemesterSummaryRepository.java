package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.StudentSemesterSummary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminStudentSemesterSummaryRepository")
public interface StudentSemesterSummaryRepository extends JpaRepository<StudentSemesterSummary, Integer> {
    List<StudentSemesterSummary> findBySemesterId(Integer semesterId);
    List<StudentSemesterSummary> findByStudentId(Integer studentId);
}
