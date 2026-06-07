package org.learn.learningmanagementbackend.repository;

import org.learn.learningmanagementbackend.model.UserChatPreference;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserChatPreferenceRepository extends JpaRepository<UserChatPreference, Long> {
    Optional<UserChatPreference> findByUserEmailAndTargetEmail(String userEmail, String targetEmail);
}
