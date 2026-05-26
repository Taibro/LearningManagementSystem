package org.learn.learningmanagementbackend.dto.projection;

import java.math.BigDecimal;

public interface MonthlySalaryDto {

    Integer getPeriodMonth();
    Integer getPeriodYear();

    BigDecimal getBaseAmount();
    BigDecimal getSessionAmount();
    BigDecimal getBonusAmount();
    BigDecimal getDeductionAmount();
    BigDecimal getNetAmount();

    BigDecimal getCoefficientSnapshot();

}
