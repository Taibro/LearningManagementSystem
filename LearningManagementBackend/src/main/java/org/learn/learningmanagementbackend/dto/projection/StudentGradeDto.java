package org.learn.learningmanagementbackend.dto.projection;

public interface StudentGradeDto {

    String getSemesterName();
    String getCourseCode();
    String getCourseName();
    String getClassCode();
    Integer getCredits();
    Double getGradeAttendance();
    Double getGradeMidterm();
    Double getGradeFinal();
    Double getGradeTotal();
    String getGradeLetter();
    String getEnrollmentStatus();
}
