package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Classes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository("schoolAdminClassesRepository")
public interface ClassesRepository extends JpaRepository<Classes, Integer> {
}
