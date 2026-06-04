package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.StudentRequest;
import org.learn.learningmanagementbackend.dto.response.StudentResponse;
import org.learn.learningmanagementbackend.model.Department;
import org.learn.learningmanagementbackend.model.Student;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.StudentRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.UserRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.DepartmentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminStudentService")
@RequiredArgsConstructor
public class StudentService {

    private final StudentRepository studentRepository;
    private final UserRepository userRepository;
    private final DepartmentRepository departmentRepository;

    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<StudentResponse> getAllStudents() {
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof org.learn.learningmanagementbackend.security.CustomUserDetails)) {
            return java.util.Collections.emptyList();
        }
        Integer userId = ((org.learn.learningmanagementbackend.security.CustomUserDetails) principal).getUserId();

        Integer schoolId;
        try {
            schoolId = entityManager.createQuery("SELECT u.school.id FROM Users u WHERE u.id = :userId", Integer.class)
                    .setParameter("userId", userId).setMaxResults(1).getSingleResult();
        } catch (Exception e) {
            return java.util.Collections.emptyList();
        }

        List<Student> students = entityManager.createQuery("SELECT s FROM Student s WHERE s.department.school.id = :schoolId", Student.class)
                .setParameter("schoolId", schoolId).getResultList();

        return students.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public StudentResponse getStudentById(Integer id) {
        Student student = studentRepository.findById(id).orElseThrow(() -> new RuntimeException("Student not found"));
        return mapToResponse(student);
    }

    public StudentResponse createStudent(StudentRequest request) {
        Users user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Student student = new Student();
        student.setUser(user);
        student.setStudentCode(request.getStudentCode());
        student.setEnrollmentYear(request.getEnrollmentYear());
        student.setMajor(request.getMajor());
        student.setClassName(request.getClassName());

        if (request.getDepartmentId() != null) {
            Department department = departmentRepository.findById(request.getDepartmentId())
                    .orElseThrow(() -> new RuntimeException("Department not found"));
            student.setDepartment(department);
        }

        return mapToResponse(studentRepository.save(student));
    }

    public StudentResponse updateStudent(Integer id, StudentRequest request) {
        Student student = studentRepository.findById(id).orElseThrow(() -> new RuntimeException("Student not found"));

        if (!student.getUser().getId().equals(request.getUserId())) {
            Users user = userRepository.findById(request.getUserId())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            student.setUser(user);
        }

        student.setStudentCode(request.getStudentCode());
        student.setEnrollmentYear(request.getEnrollmentYear());
        student.setMajor(request.getMajor());
        student.setClassName(request.getClassName());

        if (request.getDepartmentId() != null) {
            Department department = departmentRepository.findById(request.getDepartmentId())
                    .orElseThrow(() -> new RuntimeException("Department not found"));
            student.setDepartment(department);
        } else {
            student.setDepartment(null);
        }

        return mapToResponse(studentRepository.save(student));
    }

    public void deleteStudent(Integer id) {
        studentRepository.deleteById(id);
    }

    private StudentResponse mapToResponse(Student student) {
        StudentResponse response = new StudentResponse();
        response.setId(student.getId());
        response.setStudentCode(student.getStudentCode());
        response.setEnrollmentYear(student.getEnrollmentYear());
        response.setMajor(student.getMajor());
        response.setClassName(student.getClassName());
        
        if (student.getUser() != null) {
            response.setUserId(student.getUser().getId());
            response.setFullName(student.getUser().getFullName());
            response.setEmail(student.getUser().getEmail());
            response.setGender(student.getUser().getGender());
        }

        if (student.getDepartment() != null) {
            response.setDepartmentId(student.getDepartment().getId());
            response.setDepartmentName(student.getDepartment().getName());
        }

        return response;
    }
}
