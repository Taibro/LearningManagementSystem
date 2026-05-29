package org.learn.learningmanagementbackend.dto.projection;

public interface StudentSurveyListDto {
    Integer getClassId();
    String  getClassCode();
    String  getCourseName();
    String  getCourseCode();
    String  getSemesterName();
    String  getTeacherName();
    Integer getIsCompleted();  // 1 = đã khảo sát, 0 = chưa
}
