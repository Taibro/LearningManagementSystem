package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.TeacherDeclaration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TeacherDeclarationRepository extends JpaRepository<TeacherDeclaration, Integer> {

    Optional<TeacherDeclaration> findByTeacherIdAndSemesterId(Integer teacherId, Integer semesterId);
}