package org.learn.learningmanagementbackend.repository.SaasAdminRepository;

import org.learn.learningmanagementbackend.model.School;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository("saasAdminSchoolRepository")
public interface SchoolRepository extends JpaRepository<School, Integer> {

    List<School> findByIsActive(Boolean isActive);

    long countByIsActive(Boolean isActive);

    Optional<School> findByCode(String code);
}
