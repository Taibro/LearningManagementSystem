package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminTeacherRepository")
public interface TeacherRepository extends JpaRepository<Teacher, Integer> {
    List<Teacher> findByDepartmentId(Integer departmentId);
    boolean existsByTeacherCode(String teacherCode);
    boolean existsByTeacherCodeAndIdNot(String teacherCode, Integer id);
}
