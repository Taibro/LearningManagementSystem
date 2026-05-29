package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.TeacherEvaluation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeacherEvaluationRepository extends JpaRepository<TeacherEvaluation, Integer> {

    @Query("SELECT e FROM TeacherEvaluation e " +
            "JOIN FETCH e.classes c " +
            "JOIN e.teacher t " +
            "WHERE t.teacherCode = :teacherCode AND e.semester.id = :semesterId " +
            "ORDER BY e.createdAt DESC")
    List<TeacherEvaluation> findEvaluationsByTeacherAndSemester(
            @Param("teacherCode") String teacherCode,
            @Param("semesterId") Integer semesterId);
}