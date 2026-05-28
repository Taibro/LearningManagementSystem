package org.learn.learningmanagementbackend.repository;

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
    List<Enrollment> findEnrolledStudentsByClassId(@Param("classId") Integer classId);
}