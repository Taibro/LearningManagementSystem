package org.learn.learningmanagementbackend.dto.response;

import lombok.Data;
import org.learn.learningmanagementbackend.model.Department;

@Data
public class DepartmentResponse {
    private Integer id;
    private String code;
    private String name;
    private String description;
    private Integer schoolId;
    private int teacherCount;
    private int studentCount;
    private int courseCount;

    public DepartmentResponse(Department department) {
        this.id = department.getId();
        this.code = department.getCode();
        this.name = department.getName();
        this.description = department.getDescription();
        if (department.getSchool() != null) {
            this.schoolId = department.getSchool().getId();
        }
        this.teacherCount = department.getTeachers() != null ? department.getTeachers().size() : 0;
        this.studentCount = department.getStudents() != null ? department.getStudents().size() : 0;
        this.courseCount = department.getCourses() != null ? department.getCourses().size() : 0;
    }
}
