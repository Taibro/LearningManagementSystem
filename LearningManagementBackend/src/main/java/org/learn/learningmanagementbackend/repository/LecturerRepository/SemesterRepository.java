package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.Semester;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SemesterRepository extends JpaRepository<Semester, Integer> {

    Optional<Semester> findTopByOrderByStartDateDesc();
}
