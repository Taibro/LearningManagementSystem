package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class SaasSubscriptionStatsResponse {

    private BigDecimal totalRevenueYTD;
    private long pendingInvoiceCount;
    private BigDecimal pendingAmount;
    private String churnRate;
}
