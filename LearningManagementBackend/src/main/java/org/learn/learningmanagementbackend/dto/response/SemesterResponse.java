package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class SemesterResponse {
    private Integer id;
    private Integer academicYearId;
    private String academicYearName;
    private String name;
    private LocalDate startDate;
    private LocalDate endDate;
    private Boolean isActive;
}
