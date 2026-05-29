package org.learn.learningmanagementbackend.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SurveySubmitRequest {
    private Integer classId;
    private Double  scoreKnowledge;   // Câu 1-3: Kiến thức chuyên môn
    private Double  scoreMethod;      // Câu 4-6: Phương pháp giảng dạy
    private Double  scoreInteraction; // Câu 7-8: Tương tác
    private Double  scoreMaterials;   // Câu 9:   Tài liệu, học liệu
    private Double  scorePunctuality; // Câu 10:  Giờ giấc, thái độ
    private String  comment;          // Câu 11: Góp ý tự do
}
