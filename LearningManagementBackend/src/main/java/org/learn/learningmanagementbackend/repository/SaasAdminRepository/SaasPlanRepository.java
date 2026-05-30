package org.learn.learningmanagementbackend.repository.SaasAdminRepository;

import org.learn.learningmanagementbackend.model.SaasPlan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SaasPlanRepository extends JpaRepository<SaasPlan, Integer> {

    List<SaasPlan> findByIsActive(Boolean isActive);

    long countByIsActive(Boolean isActive);

    Optional<SaasPlan> findByCode(String code);
}
