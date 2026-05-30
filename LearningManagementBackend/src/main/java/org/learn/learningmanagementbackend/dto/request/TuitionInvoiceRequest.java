package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.TuitionInvoiceStatus;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
public class TuitionInvoiceRequest {

    @NotNull(message = "Student ID is required")
    private Integer studentId;

    @NotNull(message = "Semester ID is required")
    private Integer semesterId;

    @NotNull(message = "Total amount is required")
    private BigDecimal totalAmount;

    private BigDecimal paidAmount;
    
    @NotNull(message = "Due date is required")
    private LocalDate dueDate;

    @NotNull(message = "Status is required")
    private TuitionInvoiceStatus status;
}
