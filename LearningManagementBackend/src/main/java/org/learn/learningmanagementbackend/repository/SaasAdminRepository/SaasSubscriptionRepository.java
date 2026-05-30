package org.learn.learningmanagementbackend.repository.SaasAdminRepository;

import org.learn.learningmanagementbackend.model.SaasSubscription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface SaasSubscriptionRepository extends JpaRepository<SaasSubscription, Integer> {

    List<SaasSubscription> findByStatus(String status);

    List<SaasSubscription> findByEndDateBefore(LocalDate date);

    List<SaasSubscription> findByEndDateBetween(LocalDate start, LocalDate end);

    long countByStatus(String status);

    @Query("SELECT s.plan.name, COUNT(s) FROM SaasSubscription s WHERE s.status = 'ACTIVE' GROUP BY s.plan.name")
    List<Object[]> countActiveSubscriptionsByPlan();

    Optional<SaasSubscription> findBySchool_IdAndStatus(Integer schoolId, String status);

    @Query("SELECT s FROM SaasSubscription s JOIN FETCH s.school JOIN FETCH s.plan WHERE s.status = 'ACTIVE' AND s.endDate BETWEEN :start AND :end")
    List<SaasSubscription> findExpiringSubscriptions(@Param("start") LocalDate start, @Param("end") LocalDate end);
}
