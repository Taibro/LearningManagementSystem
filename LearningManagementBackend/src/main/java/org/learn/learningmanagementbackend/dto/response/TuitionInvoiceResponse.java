package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.TuitionInvoiceStatus;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class TuitionInvoiceResponse {
    private Integer id;
    private Integer studentId;
    private String studentCode;
    private String studentName;
    private Integer semesterId;
    private String semesterName;
    private BigDecimal totalAmount;
    private BigDecimal paidAmount;
    private LocalDate dueDate;
    private TuitionInvoiceStatus status;
    private LocalDateTime createdAt;
}
