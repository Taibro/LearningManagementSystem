package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.EnrollmentRequest;
import org.learn.learningmanagementbackend.dto.response.EnrollmentResponse;
import org.learn.learningmanagementbackend.model.Classes;
import org.learn.learningmanagementbackend.model.Enrollment;
import org.learn.learningmanagementbackend.model.Student;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.EnrollmentRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminEnrollmentService")
@RequiredArgsConstructor
public class EnrollmentService {

    private final EnrollmentRepository enrollmentRepository;
    // Tạm thời giả định có tồn tại các repository này hoặc dùng object reference
    
    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<EnrollmentResponse> getAllEnrollments() {
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

        List<Enrollment> enrollments = entityManager.createQuery("SELECT e FROM Enrollment e WHERE e.student.department.school.id = :schoolId", Enrollment.class)
                .setParameter("schoolId", schoolId).getResultList();

        return enrollments.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public List<EnrollmentResponse> getEnrollmentsByClass(Integer classId) {
        return enrollmentRepository.findByClassesId(classId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public EnrollmentResponse getEnrollmentById(Integer id) {
        Enrollment enrollment = enrollmentRepository.findById(id).orElseThrow(() -> new RuntimeException("Enrollment not found"));
        return mapToResponse(enrollment);
    }

    public EnrollmentResponse createEnrollment(EnrollmentRequest request) {
        Enrollment enrollment = new Enrollment();
        
        Student student = new Student();
        student.setId(request.getStudentId());
        
        Classes classes = new Classes();
        classes.setId(request.getClassId());
        
        enrollment.setStudent(student);
        enrollment.setClasses(classes);
        enrollment.setEnrollmentDate(request.getEnrollmentDate() != null ? request.getEnrollmentDate() : LocalDateTime.now());
        enrollment.setStatus(request.getStatus());
        enrollment.setGradeAttendance(request.getGradeAttendance());
        enrollment.setGradeMidterm(request.getGradeMidterm());
        enrollment.setGradeFinal(request.getGradeFinal());
        enrollment.setGradeTotal(request.getGradeTotal());
        enrollment.setGradeLetter(request.getGradeLetter());
        
        return mapToResponse(enrollmentRepository.save(enrollment));
    }

    public EnrollmentResponse updateEnrollment(Integer id, EnrollmentRequest request) {
        Enrollment enrollment = enrollmentRepository.findById(id).orElseThrow(() -> new RuntimeException("Enrollment not found"));

        if (!enrollment.getStudent().getId().equals(request.getStudentId())) {
            Student student = new Student();
            student.setId(request.getStudentId());
            enrollment.setStudent(student);
        }

        if (!enrollment.getClasses().getId().equals(request.getClassId())) {
            Classes classes = new Classes();
            classes.setId(request.getClassId());
            enrollment.setClasses(classes);
        }

        enrollment.setStatus(request.getStatus());
        enrollment.setGradeAttendance(request.getGradeAttendance());
        enrollment.setGradeMidterm(request.getGradeMidterm());
        enrollment.setGradeFinal(request.getGradeFinal());
        enrollment.setGradeTotal(request.getGradeTotal());
        enrollment.setGradeLetter(request.getGradeLetter());

        return mapToResponse(enrollmentRepository.save(enrollment));
    }

    public void deleteEnrollment(Integer id) {
        enrollmentRepository.deleteById(id);
    }

    private EnrollmentResponse mapToResponse(Enrollment enrollment) {
        EnrollmentResponse response = new EnrollmentResponse();
        response.setId(enrollment.getId());
        
        if (enrollment.getStudent() != null) {
            response.setStudentId(enrollment.getStudent().getId());
            response.setStudentCode(enrollment.getStudent().getStudentCode());
            if (enrollment.getStudent().getUser() != null) {
                response.setStudentName(enrollment.getStudent().getUser().getFullName());
            }
        }
        
        if (enrollment.getClasses() != null) {
            response.setClassId(enrollment.getClasses().getId());
            response.setClassCode(enrollment.getClasses().getCode());
        }
        
        response.setEnrollmentDate(enrollment.getEnrollmentDate());
        response.setStatus(enrollment.getStatus());
        response.setGradeAttendance(enrollment.getGradeAttendance());
        response.setGradeMidterm(enrollment.getGradeMidterm());
        response.setGradeFinal(enrollment.getGradeFinal());
        response.setGradeTotal(enrollment.getGradeTotal());
        response.setGradeLetter(enrollment.getGradeLetter());
        
        return response;
    }
}
