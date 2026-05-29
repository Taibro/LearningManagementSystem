package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.AcademicYear;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminAcademicYearRepository")
public interface AcademicYearRepository extends JpaRepository<AcademicYear, Integer> {
    List<AcademicYear> findBySchoolId(Integer schoolId);
}
