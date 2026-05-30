package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.StudentSemesterSummaryRequest;
import org.learn.learningmanagementbackend.dto.response.StudentSemesterSummaryResponse;
import org.learn.learningmanagementbackend.model.Semester;
import org.learn.learningmanagementbackend.model.Student;
import org.learn.learningmanagementbackend.model.StudentSemesterSummary;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.SemesterRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.StudentRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.StudentSemesterSummaryRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminStudentSemesterSummaryService")
@RequiredArgsConstructor
public class StudentSemesterSummaryService {

    private final StudentSemesterSummaryRepository summaryRepository;
    private final StudentRepository studentRepository;
    private final SemesterRepository semesterRepository;

    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<StudentSemesterSummaryResponse> getAllSummaries() {
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof org.learn.learningmanagementbackend.security.CustomUserDetails)) {
            return java.util.Collections.emptyList();
        }
        Integer userId = ((org.learn.learningmanagementbackend.security.CustomUserDetails) principal).getUserId();

        Integer schoolId;
        try {
            schoolId = entityManager.createQuery("SELECT us.school.id FROM UserSchool us WHERE us.user.id = :userId", Integer.class)
                    .setParameter("userId", userId).setMaxResults(1).getSingleResult();
        } catch (Exception e) {
            return java.util.Collections.emptyList();
        }

        List<StudentSemesterSummary> summaries = entityManager.createQuery("SELECT s FROM StudentSemesterSummary s WHERE s.student.department.school.id = :schoolId", StudentSemesterSummary.class)
                .setParameter("schoolId", schoolId).getResultList();

        return summaries.stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public List<StudentSemesterSummaryResponse> getSummariesBySemester(Integer semesterId) {
        return summaryRepository.findBySemesterId(semesterId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public StudentSemesterSummaryResponse getSummaryById(Integer id) {
        StudentSemesterSummary summary = summaryRepository.findById(id).orElseThrow(() -> new RuntimeException("Summary not found"));
        return mapToResponse(summary);
    }

    public StudentSemesterSummaryResponse createSummary(StudentSemesterSummaryRequest request) {
        Student student = studentRepository.findById(request.getStudentId())
                .orElseThrow(() -> new RuntimeException("Student not found"));
        Semester semester = semesterRepository.findById(request.getSemesterId())
                .orElseThrow(() -> new RuntimeException("Semester not found"));

        StudentSemesterSummary summary = new StudentSemesterSummary();
        summary.setStudent(student);
        summary.setSemester(semester);
        summary.setGpa(request.getGpa());
        summary.setCreditsEarned(request.getCreditsEarned());
        summary.setConductScore(request.getConductScore());
        summary.setConductGrade(request.getConductGrade());
        summary.setScholarshipName(request.getScholarshipName());
        summary.setScholarshipAmount(request.getScholarshipAmount());
        summary.setNotes(request.getNotes());

        return mapToResponse(summaryRepository.save(summary));
    }

    public StudentSemesterSummaryResponse updateSummary(Integer id, StudentSemesterSummaryRequest request) {
        StudentSemesterSummary summary = summaryRepository.findById(id).orElseThrow(() -> new RuntimeException("Summary not found"));

        if (!summary.getStudent().getId().equals(request.getStudentId())) {
            Student student = studentRepository.findById(request.getStudentId())
                    .orElseThrow(() -> new RuntimeException("Student not found"));
            summary.setStudent(student);
        }

        if (!summary.getSemester().getId().equals(request.getSemesterId())) {
            Semester semester = semesterRepository.findById(request.getSemesterId())
                    .orElseThrow(() -> new RuntimeException("Semester not found"));
            summary.setSemester(semester);
        }

        summary.setGpa(request.getGpa());
        summary.setCreditsEarned(request.getCreditsEarned());
        summary.setConductScore(request.getConductScore());
        summary.setConductGrade(request.getConductGrade());
        summary.setScholarshipName(request.getScholarshipName());
        summary.setScholarshipAmount(request.getScholarshipAmount());
        summary.setNotes(request.getNotes());

        return mapToResponse(summaryRepository.save(summary));
    }

    public void deleteSummary(Integer id) {
        summaryRepository.deleteById(id);
    }

    private StudentSemesterSummaryResponse mapToResponse(StudentSemesterSummary summary) {
        StudentSemesterSummaryResponse response = new StudentSemesterSummaryResponse();
        response.setId(summary.getId());
        
        if (summary.getStudent() != null) {
            response.setStudentId(summary.getStudent().getId());
            response.setStudentCode(summary.getStudent().getStudentCode());
            if (summary.getStudent().getUser() != null) {
                response.setStudentName(summary.getStudent().getUser().getFullName());
            }
        }
        
        if (summary.getSemester() != null) {
            response.setSemesterId(summary.getSemester().getId());
            response.setSemesterName(summary.getSemester().getName());
        }
        
        response.setGpa(summary.getGpa());
        response.setCreditsEarned(summary.getCreditsEarned());
        response.setConductScore(summary.getConductScore());
        response.setConductGrade(summary.getConductGrade());
        response.setScholarshipName(summary.getScholarshipName());
        response.setScholarshipAmount(summary.getScholarshipAmount());
        response.setNotes(summary.getNotes());
        
        return response;
    }
}
