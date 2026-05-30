package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.Gender;

import java.time.LocalDate;

@Getter
@Setter
public class UserRequest {

    @NotBlank(message = "Citizen ID is required")
    private String citizenIdNumber;

    @NotBlank(message = "Full name is required")
    private String fullName;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;

    private String phone;
    private String address;
    private LocalDate dateOfBirth;
    private Gender gender;
    private Boolean isActive;
    
    // For password creation/update if needed
    private String password;
}
