package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;
import java.math.BigDecimal;

@Data
@Builder
public class ScholarshipDto {
    private Integer id; // Mocks STT if needed, or semester id
    private String semesterName;
    private BigDecimal gpa;
    private Integer totalCredits;
    private String academicRank; // Xuất sắc, Giỏi, Khá, Không đạt
    private String conductRank; // Xuất sắc, Tốt, Khá, Không đạt
    private String scholarshipType; // Xuất sắc, Giỏi, Khá, Không có
    private BigDecimal scholarshipAmount;
}
