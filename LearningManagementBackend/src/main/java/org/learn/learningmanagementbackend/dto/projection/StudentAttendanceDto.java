package org.learn.learningmanagementbackend.dto.projection;

public interface StudentAttendanceDto {

    String getSemesterName();
    String getClassCode();
    String getCourseName();
    Integer getCredits();
    Long getAbsentWithPermission();       // Số tiết vắng có phép (EXCUSED)
    Long getAbsentWithoutPermission();    // Số tiết vắng không phép (ABSENT)
    Long getLate();                        // Số tiết đi trễ (LATE)
}
