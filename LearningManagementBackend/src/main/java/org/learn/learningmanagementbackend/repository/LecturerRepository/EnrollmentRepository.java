package org.learn.learningmanagementbackend.repository.LecturerRepository;

import jakarta.validation.constraints.NotNull;
import org.learn.learningmanagementbackend.enums.EnrollmentStatus;
import org.learn.learningmanagementbackend.model.Enrollment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Integer> {

    @Query("SELECT e FROM Enrollment e " +
            "JOIN FETCH e.student s " +
            "JOIN FETCH s.user u " +
            "WHERE e.classes.id = :classId AND e.status = 'enrolled' " +
            "ORDER BY s.studentCode ASC")
    List<Enrollment> getEnrolledStudentsByClassId(@Param("classId") Integer classId);

    boolean existsByStudentIdAndClassesIdAndStatus(
            @NotNull(message = "Không xác định được sinh viên") Integer studentId,
            Integer classId,
            EnrollmentStatus status);

    boolean existsByStudentIdAndClassesIdAndStatusIn(Integer studentId, Integer classId, List<EnrollmentStatus> statuses);

    java.util.Optional<Enrollment> findByStudentIdAndClassesIdAndStatusIn(Integer studentId, Integer classId, List<EnrollmentStatus> statuses);

    long countByClassesIdAndStatusIn(Integer classesId, List<EnrollmentStatus> statuses);

    @Query("SELECT e FROM Enrollment e JOIN FETCH e.classes c JOIN FETCH c.course WHERE e.student.id = :studentId AND c.semester.id = :semesterId AND e.status = :status")
    List<Enrollment> findByStudentIdAndSemesterIdAndStatus(
            @Param("studentId") Integer studentId, 
            @Param("semesterId") Integer semesterId, 
            @Param("status") EnrollmentStatus status);
}