package org.learn.learningmanagementbackend.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TeacherDropdownResponse {
    private Integer teacherId;
    private String displayLabel; // Hiển thị: "Trần Thị B - Bộ môn CNTT"
}