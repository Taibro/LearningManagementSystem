package org.learn.learningmanagementbackend.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseRegistrationRequest {
    private Integer classId;
    /** NORMAL | RETAKE | IMPROVE */
    private String type;
}
