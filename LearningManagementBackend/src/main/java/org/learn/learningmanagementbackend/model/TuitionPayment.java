package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.PaymentMethod;
import org.learn.learningmanagementbackend.enums.TuitionPaymentStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "Tuition_payment")
public class TuitionPayment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "invoice_id", nullable = false)
    private TuitionInvoice tuitionInvoice;

    @Column(name = "amount", nullable = false)
    private BigDecimal amount;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_method", nullable = false)
    private PaymentMethod paymentMethod;

    @Column(name = "transaction_code")
    private String transactionCode;

    @Column(name = "payment_date", nullable = false)
    private LocalDateTime paymentDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private TuitionPaymentStatus status;

    @Column(name = "note")
    private String note;
}
