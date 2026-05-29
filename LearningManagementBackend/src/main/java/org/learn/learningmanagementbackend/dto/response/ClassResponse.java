package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ClassStatus;

import java.util.List;

@Getter
@Setter
public class ClassResponse {
    private Integer id;
    private String code;
    private Integer courseId;
    private String courseName;
    private Integer semesterId;
    private String semesterName;
    private Integer maxStudents;
    private Integer enrolledStudents;
    private ClassStatus status;
    private String notes;
    private List<String> teachers; // e.g. "main: Nguyễn Văn An"
}
