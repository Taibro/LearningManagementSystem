package org.learn.learningmanagementbackend.dto.response;

import lombok.Data;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.model.Users;

@Data
public class TeacherResponse {
    private Integer id; // Teacher ID
    private Integer userId; // User ID
    
    // User info
    private String fullName;
    private String email;
    private String phone;
    private String avatarUrl;
    
    // Teacher info
    private String teacherCode;
    private String degree;
    private String specialization;
    
    // Department info
    private Integer departmentId;
    private String departmentName;
    
    public TeacherResponse(Teacher teacher) {
        this.id = teacher.getId();
        this.teacherCode = teacher.getTeacherCode();
        this.degree = teacher.getDegree();
        this.specialization = teacher.getSpecialization();
        
        if (teacher.getDepartment() != null) {
            this.departmentId = teacher.getDepartment().getId();
            this.departmentName = teacher.getDepartment().getName();
        }
        
        if (teacher.getUser() != null) {
            Users user = teacher.getUser();
            this.userId = user.getId();
            this.fullName = user.getFullName();
            this.email = user.getEmail();
            this.phone = user.getPhone();
            this.avatarUrl = user.getAvatarUrl();
        }
    }
}
