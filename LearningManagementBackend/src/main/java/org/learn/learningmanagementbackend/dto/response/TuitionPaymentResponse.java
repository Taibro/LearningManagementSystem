package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.PaymentMethod;
import org.learn.learningmanagementbackend.enums.TuitionPaymentStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class TuitionPaymentResponse {
    private Integer id;
    private Integer invoiceId;
    private String studentName;
    private BigDecimal amount;
    private PaymentMethod paymentMethod;
    private String transactionCode;
    private LocalDateTime paymentDate;
    private TuitionPaymentStatus status;
    private String note;
}
