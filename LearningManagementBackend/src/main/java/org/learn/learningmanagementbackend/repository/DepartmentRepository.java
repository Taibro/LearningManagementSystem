package org.learn.learningmanagementbackend.repository;

import org.learn.learningmanagementbackend.model.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Integer> {
    List<Department> findBySchoolId(Integer schoolId);
    Optional<Department> findByCodeAndSchoolId(String code, Integer schoolId);
}
