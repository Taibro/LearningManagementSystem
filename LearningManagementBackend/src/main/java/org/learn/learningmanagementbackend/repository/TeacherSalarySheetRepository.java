package org.learn.learningmanagementbackend.repository;

import org.learn.learningmanagementbackend.dto.projection.MonthlySalaryDto;
import org.learn.learningmanagementbackend.model.TeacherSalarySheet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Repository;

import java.time.Year;
import java.util.Optional;

@Repository
public interface TeacherSalarySheetRepository extends JpaRepository<TeacherSalarySheet, Integer> {

    boolean existsByTeacherIdAndPeriodMonthAndPeriodYear(Integer id, byte month, Year of);

    @Query("""
        SELECT 
            s.periodMonth AS periodMonth,
            s.periodYear AS periodYear,
            s.baseAmount AS baseAmount,
            s.sessionAmount AS sessionAmount,
            s.bonusAmount AS bonusAmount,
            s.deductionAmount AS deductionAmount,
            s.netAmount AS netAmount,
            s.coefficientSnapshot AS coefficientSnapshot
        FROM TeacherSalarySheet s
        JOIN s.teacher t
        WHERE t.teacherCode = :teacherCode
        AND s.periodYear = :year
        AND s.periodMonth = :month
        AND s.status != 'CANCELLED'
""")
    Optional<MonthlySalaryDto> getSalaryByMonthAndYear(
      @Param("teacherCode") String teacherCode,
      @Param("year") Integer year,
      @Param("month") Integer month
    );
}
