package org.learn.learningmanagementbackend.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TeacherChatResponse {
    private Integer teacherId;
    private String teacherName;
    private String departmentName;
    private String email;
}
