package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.PaymentMethod;
import org.learn.learningmanagementbackend.enums.TuitionPaymentStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class TuitionPaymentRequest {

    @NotNull(message = "Invoice ID is required")
    private Integer invoiceId;

    @NotNull(message = "Amount is required")
    private BigDecimal amount;

    @NotNull(message = "Payment method is required")
    private PaymentMethod paymentMethod;

    private String transactionCode;

    @NotNull(message = "Payment date is required")
    private LocalDateTime paymentDate;

    @NotNull(message = "Status is required")
    private TuitionPaymentStatus status;

    private String note;
}
