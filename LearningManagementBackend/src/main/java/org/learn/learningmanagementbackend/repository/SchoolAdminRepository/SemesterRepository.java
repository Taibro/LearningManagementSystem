package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Semester;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminSemesterRepository")
public interface SemesterRepository extends JpaRepository<Semester, Integer> {
    List<Semester> findByAcademicYearId(Integer academicYearId);
}
