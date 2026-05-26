package org.learn.learningmanagementbackend.repository;

import org.learn.learningmanagementbackend.model.TeacherSalaryDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeacherSalaryDetailRepository extends JpaRepository<TeacherSalaryDetail, Integer> {
}
