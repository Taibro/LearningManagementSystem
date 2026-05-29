package org.learn.learningmanagementbackend.repository.SaasAdminRepository;

import org.learn.learningmanagementbackend.model.School;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository("saasAdminSchoolRepository")
public interface SchoolRepository extends JpaRepository<School, Integer> {
}
