package org.learn.learningmanagementbackend.dto.projection;

public interface StudentCourseRegDto {
    Integer getClassId();
    String  getClassCode();
    Integer getCourseId();
    String  getCourseCode();
    String  getCourseName();
    Integer getCredits();
    Integer getSemesterId();
    String  getSemesterName();
    String  getTeacherName();
    Integer getEnrolledCount();
    Integer getMaxStudents();
    // Schedule
    Integer getDayOfWeek();
    String  getStartTime();   // "HH:mm"
    String  getEndTime();
    Integer getStartPeriod();
    Integer getEndPeriod();
    String  getRoomNumber();
    String  getBuilding();
    // Trạng thái
    Integer getAlreadyEnrolled(); // 1 = đã đăng ký (thuộc loại bất kỳ)
}
