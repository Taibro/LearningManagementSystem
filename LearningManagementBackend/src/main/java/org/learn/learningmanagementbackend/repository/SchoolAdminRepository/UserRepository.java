package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository("schoolAdminUserRepository")
public interface UserRepository extends JpaRepository<Users, Integer> {
    boolean existsByEmail(String email);
    boolean existsByCitizenIdNumber(String citizenIdNumber);
}
