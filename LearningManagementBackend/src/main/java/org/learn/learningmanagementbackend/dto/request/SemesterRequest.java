package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class SemesterRequest {

    @NotNull(message = "Academic Year ID is required")
    private Integer academicYearId;

    @NotBlank(message = "Semester name is required")
    private String name;

    @NotNull(message = "Start date is required")
    private LocalDate startDate;

    @NotNull(message = "End date is required")
    private LocalDate endDate;

    private Boolean isActive;
}
