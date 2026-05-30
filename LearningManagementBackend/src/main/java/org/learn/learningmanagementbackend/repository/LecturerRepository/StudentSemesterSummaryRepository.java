package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.StudentSemesterSummary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface StudentSemesterSummaryRepository extends JpaRepository<StudentSemesterSummary, Integer> {
    Optional<StudentSemesterSummary> findByStudentIdAndSemesterId(Integer studentId, Integer semesterId);
    List<StudentSemesterSummary> findByStudentId(Integer studentId);
}
