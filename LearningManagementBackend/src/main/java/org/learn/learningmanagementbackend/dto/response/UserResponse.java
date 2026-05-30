package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.Gender;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class UserResponse {
    private Integer id;
    private String citizenIdNumber;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private LocalDate dateOfBirth;
    private Gender gender;
    private String avatarUrl;
    private Boolean isActive;
    private LocalDateTime lastLoginAt;
    
    // Role based on relations
    private String role; // "teacher", "student", "admin", or "user"
}
