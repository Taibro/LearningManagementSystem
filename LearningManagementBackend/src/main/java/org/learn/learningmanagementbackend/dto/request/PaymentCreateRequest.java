package org.learn.learningmanagementbackend.dto.request;

import lombok.Data;
import org.learn.learningmanagementbackend.enums.PaymentMethod;
import java.math.BigDecimal;
import java.util.List;

@Data
public class PaymentCreateRequest {
    private Integer semesterId;
    private PaymentMethod paymentMethod;
    private BigDecimal totalAmount;
    private List<CoursePaymentData> courses;

    @Data
    public static class CoursePaymentData {
        private String classCode;
        private String courseCode;
        private String courseName;
        private Integer credits;
        private BigDecimal amount;
    }
}
