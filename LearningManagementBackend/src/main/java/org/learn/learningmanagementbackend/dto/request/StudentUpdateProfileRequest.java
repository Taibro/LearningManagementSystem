package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class StudentUpdateProfileRequest {

    @Email(message = "Email sai định dạng")
    private String email;

    @Pattern(regexp = "^(0|\\+84)[0-9]{9}$", message = "Số điện thoại không hợp lệ")
    private String phone;

    private String address;
    
    private String gender; // MALE, FEMALE, OTHER
}
