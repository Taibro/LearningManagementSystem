package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class SaasInvoiceResponse {

    private Integer id;
    private String invoiceCode;
    private String schoolName;
    private String planName;
    private String billingCycle;
    private BigDecimal amount;
    private String paymentMethod;
    private String paymentStatus;
    private LocalDateTime paidAt;
    private LocalDateTime createdAt;
}
