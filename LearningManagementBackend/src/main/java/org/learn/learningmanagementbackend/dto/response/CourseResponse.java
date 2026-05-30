package org.learn.learningmanagementbackend.dto.response;

import lombok.Data;
import org.learn.learningmanagementbackend.model.Course;

@Data
public class CourseResponse {
    private Integer id;
    private String code;
    private String name;
    private Integer credits;
    private Integer theorySessions;
    private Integer practicalSessions;
    private Integer totalSessions;
    private String description;
    private Integer departmentId;
    private String departmentName;
    private Boolean isActive;

    public CourseResponse(Course course) {
        this.id = course.getId();
        this.code = course.getCode();
        this.name = course.getName();
        this.credits = course.getCredits();
        this.theorySessions = course.getTheorySessions();
        this.practicalSessions = course.getPracticalSessions();
        this.totalSessions = course.getTotalSessions();
        this.description = course.getDescription();
        this.isActive = course.getIsActive() != null ? course.getIsActive() : true;
        
        if (course.getDepartment() != null) {
            this.departmentId = course.getDepartment().getId();
            this.departmentName = course.getDepartment().getName();
        }
    }
}
