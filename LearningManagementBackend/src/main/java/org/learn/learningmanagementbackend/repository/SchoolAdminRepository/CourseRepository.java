package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminCourseRepository")
public interface CourseRepository extends JpaRepository<Course, Integer> {
    List<Course> findByDepartmentId(Integer departmentId);
    boolean existsByCode(String code);
    boolean existsByCodeAndIdNot(String code, Integer id);
}
