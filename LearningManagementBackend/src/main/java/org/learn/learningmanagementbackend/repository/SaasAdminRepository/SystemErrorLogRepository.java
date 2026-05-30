package org.learn.learningmanagementbackend.repository.SaasAdminRepository;

import org.learn.learningmanagementbackend.model.SystemErrorLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SystemErrorLogRepository extends JpaRepository<SystemErrorLog, Long> {

    List<SystemErrorLog> findByIsResolved(Boolean isResolved);

    List<SystemErrorLog> findAllByOrderByCreatedAtDesc();

    long countByIsResolved(Boolean isResolved);
}
