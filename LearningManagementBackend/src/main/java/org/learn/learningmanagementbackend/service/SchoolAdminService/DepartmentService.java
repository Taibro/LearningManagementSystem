package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.DepartmentRequest;
import org.learn.learningmanagementbackend.dto.response.DepartmentResponse;
import org.learn.learningmanagementbackend.model.Department;
import org.learn.learningmanagementbackend.model.School;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.DepartmentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DepartmentService {

    private final DepartmentRepository departmentRepository;

    public List<DepartmentResponse> getAllDepartmentsBySchool(Integer schoolId) {
        return departmentRepository.findBySchoolId(schoolId)
                .stream()
                .map(DepartmentResponse::new)
                .collect(Collectors.toList());
    }

    public DepartmentResponse createDepartment(DepartmentRequest request) {
        // Check duplicated code
        if (departmentRepository.findByCodeAndSchoolId(request.getCode(), request.getSchoolId()).isPresent()) {
            throw new RuntimeException("Mã khoa đã tồn tại trong trường này");
        }

        Department department = new Department();
        department.setCode(request.getCode());
        department.setName(request.getName());
        department.setDescription(request.getDescription());

        // Associate with School
        School school = new School();
        school.setId(request.getSchoolId());
        department.setSchool(school);

        department = departmentRepository.save(department);
        return new DepartmentResponse(department);
    }

    public DepartmentResponse updateDepartment(Integer id, DepartmentRequest request) {
        Department department = departmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy khoa"));

        department.setName(request.getName());
        department.setDescription(request.getDescription());

        department = departmentRepository.save(department);
        return new DepartmentResponse(department);
    }

    public void deleteDepartment(Integer id) {
        if (!departmentRepository.existsById(id)) {
            throw new RuntimeException("Không tìm thấy khoa");
        }
        departmentRepository.deleteById(id);
    }
}
