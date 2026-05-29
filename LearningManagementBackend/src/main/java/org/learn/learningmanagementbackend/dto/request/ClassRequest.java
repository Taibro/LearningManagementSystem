package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ClassStatus;

@Getter
@Setter
public class ClassRequest {

    @NotNull(message = "Code is required")
    private String code;

    @NotNull(message = "Course ID is required")
    private Integer courseId;

    @NotNull(message = "Semester ID is required")
    private Integer semesterId;

    private Integer maxStudents;
    private ClassStatus status;
    private String notes;
}
