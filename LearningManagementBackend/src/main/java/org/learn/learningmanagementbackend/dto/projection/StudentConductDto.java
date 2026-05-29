package org.learn.learningmanagementbackend.dto.projection;

import java.math.BigDecimal;

public interface StudentConductDto {

    String getSemesterName();
    BigDecimal getGpa();
    Integer getCreditsEarned();
    Integer getConductScore();
    String getConductGrade();
    String getScholarshipName();
    BigDecimal getScholarshipAmount();
    String getNotes();
}
