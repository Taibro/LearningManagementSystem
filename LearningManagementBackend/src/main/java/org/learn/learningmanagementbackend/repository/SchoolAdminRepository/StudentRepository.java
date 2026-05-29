package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository("schoolAdminStudentRepository")
public interface StudentRepository extends JpaRepository<Student, Integer> {
}
