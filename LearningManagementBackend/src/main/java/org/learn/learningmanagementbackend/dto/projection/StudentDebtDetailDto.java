package org.learn.learningmanagementbackend.dto.projection;

import java.math.BigDecimal;

public interface StudentDebtDetailDto {
    // Học kỳ
    Integer getSemesterId();
    String  getSemesterName();
    String  getSemesterStartDate(); // yyyy-MM-dd

    // Lớp & môn
    String  getClassCode();
    String  getCourseCode();
    String  getCourseName();
    Integer getCredits();

    // Tiền
    BigDecimal getMucNop();       // credits * 1135000 (mức phải đóng)
    BigDecimal getSoTienNop();    // tiền đã đóng cho môn này (phân bổ theo tỉ lệ)

    // Thanh toán
    Integer getIsPaid();          // 1 = đã đóng, 0 = chưa
    String  getPaidDate();        // ngày nộp (NULL nếu chưa)

    // Invoice tổng của kỳ (để tính công nợ)
    BigDecimal getInvoicePaid();  // tổng đã đóng trong kỳ
    BigDecimal getInvoiceTotal(); // tổng phải đóng trong kỳ
}
