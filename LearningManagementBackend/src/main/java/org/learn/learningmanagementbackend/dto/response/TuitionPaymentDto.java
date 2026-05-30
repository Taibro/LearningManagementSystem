package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;
import org.learn.learningmanagementbackend.enums.PaymentMethod;
import org.learn.learningmanagementbackend.enums.TuitionPaymentStatus;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
public class TuitionPaymentDto {
    private Integer id;
    private String transactionCode;
    private BigDecimal amount;
    private PaymentMethod paymentMethod;
    private LocalDateTime paymentDate;
    private TuitionPaymentStatus status;
    private String note;
    private String courseData; // JSON string
}
