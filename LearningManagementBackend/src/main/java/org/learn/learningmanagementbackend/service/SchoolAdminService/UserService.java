package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.UserRequest;
import org.learn.learningmanagementbackend.dto.response.UserResponse;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminUserService")
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public List<UserResponse> getAllUsers() {
        return userRepository.findAll().stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public UserResponse getUserById(Integer id) {
        Users user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        return mapToResponse(user);
    }

    public UserResponse createUser(UserRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        if (userRepository.existsByCitizenIdNumber(request.getCitizenIdNumber())) {
            throw new RuntimeException("Citizen ID already exists");
        }

        Users user = new Users();
        user.setCitizenIdNumber(request.getCitizenIdNumber());
        user.setFullName(request.getFullName());
        user.setEmail(request.getEmail());
        user.setPhone(request.getPhone());
        user.setAddress(request.getAddress());
        user.setDateOfBirth(request.getDateOfBirth());
        user.setGender(request.getGender());
        user.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);
        
        // Simple hash mock, use BCrypt in reality
        if (request.getPassword() != null && !request.getPassword().isEmpty()) {
            user.setPasswordHash(request.getPassword()); // MOCK
        }

        return mapToResponse(userRepository.save(user));
    }

    public UserResponse updateUser(Integer id, UserRequest request) {
        Users user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));

        if (!user.getEmail().equals(request.getEmail()) && userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        if (!user.getCitizenIdNumber().equals(request.getCitizenIdNumber()) && userRepository.existsByCitizenIdNumber(request.getCitizenIdNumber())) {
            throw new RuntimeException("Citizen ID already exists");
        }

        user.setCitizenIdNumber(request.getCitizenIdNumber());
        user.setFullName(request.getFullName());
        user.setEmail(request.getEmail());
        user.setPhone(request.getPhone());
        user.setAddress(request.getAddress());
        user.setDateOfBirth(request.getDateOfBirth());
        user.setGender(request.getGender());
        user.setIsActive(request.getIsActive() != null ? request.getIsActive() : user.getIsActive());

        if (request.getPassword() != null && !request.getPassword().isEmpty()) {
            user.setPasswordHash(request.getPassword()); // MOCK
        }

        return mapToResponse(userRepository.save(user));
    }

    public void deleteUser(Integer id) {
        userRepository.deleteById(id);
    }

    private UserResponse mapToResponse(Users user) {
        UserResponse response = new UserResponse();
        response.setId(user.getId());
        response.setCitizenIdNumber(user.getCitizenIdNumber());
        response.setFullName(user.getFullName());
        response.setEmail(user.getEmail());
        response.setPhone(user.getPhone());
        response.setAddress(user.getAddress());
        response.setDateOfBirth(user.getDateOfBirth());
        response.setGender(user.getGender());
        response.setAvatarUrl(user.getAvatarUrl());
        response.setIsActive(user.getIsActive());
        response.setLastLoginAt(user.getLastLoginAt());
        
        if (user.getTeacher() != null) {
            response.setRole("teacher");
        } else if (user.getStudent() != null) {
            response.setRole("student");
        } else {
            response.setRole("admin"); // Default or superuser
        }
        return response;
    }
}
