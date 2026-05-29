package org.learn.learningmanagementbackend.dto.projection;

import java.math.BigDecimal;
import java.time.LocalDate;

public interface StudentTuitionDto {

    Integer getInvoiceId();
    String getSemesterName();
    BigDecimal getTotalAmount();
    BigDecimal getPaidAmount();
    LocalDate getDueDate();
    String getStatus();
}
