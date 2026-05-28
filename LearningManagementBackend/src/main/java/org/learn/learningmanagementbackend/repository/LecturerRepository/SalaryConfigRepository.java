package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.model.SalaryConfig;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;


public interface SalaryConfigRepository extends JpaRepository<SalaryConfig, Integer> {

    @Query("""
                    SELECT sc FROM SalaryConfig sc
                    JOIN FETCH sc.salaryGrade sg
                    WHERE sg.degree = :degree
                        AND sc.isActive = true
                    ORDER BY sc.createdAt DESC LIMIT 1
            """)
    Optional<SalaryConfig> findActiveConfigByDegree(@Param("degree") String degree);

}
