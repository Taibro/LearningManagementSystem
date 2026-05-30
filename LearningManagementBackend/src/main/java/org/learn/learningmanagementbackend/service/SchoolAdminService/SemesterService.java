package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SemesterRequest;
import org.learn.learningmanagementbackend.dto.response.SemesterResponse;
import org.learn.learningmanagementbackend.model.AcademicYear;
import org.learn.learningmanagementbackend.model.Semester;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.SemesterRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminSemesterService")
@RequiredArgsConstructor
public class SemesterService {

    private final SemesterRepository semesterRepository;
    // Assume AcademicYearRepository exists, if not we will use entity manager or create it. 
    // We can just set id for AcademicYear if we use getReferenceById, but it's better to fetch it.
    // For now we will create a dummy AcademicYear and just set the ID to avoid creating extra repos if not needed.

    public List<SemesterResponse> getAllSemestersByAcademicYear(Integer academicYearId) {
        return semesterRepository.findByAcademicYearId(academicYearId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public SemesterResponse getSemesterById(Integer id) {
        Semester semester = semesterRepository.findById(id).orElseThrow(() -> new RuntimeException("Semester not found"));
        return mapToResponse(semester);
    }

    public SemesterResponse createSemester(SemesterRequest request) {
        Semester semester = new Semester();
        AcademicYear ay = new AcademicYear();
        ay.setId(request.getAcademicYearId());
        semester.setAcademicYear(ay);
        semester.setName(request.getName());
        semester.setStartDate(request.getStartDate());
        semester.setEndDate(request.getEndDate());
        semester.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        return mapToResponse(semesterRepository.save(semester));
    }

    public SemesterResponse updateSemester(Integer id, SemesterRequest request) {
        Semester semester = semesterRepository.findById(id).orElseThrow(() -> new RuntimeException("Semester not found"));

        if (!semester.getAcademicYear().getId().equals(request.getAcademicYearId())) {
            AcademicYear ay = new AcademicYear();
            ay.setId(request.getAcademicYearId());
            semester.setAcademicYear(ay);
        }

        semester.setName(request.getName());
        semester.setStartDate(request.getStartDate());
        semester.setEndDate(request.getEndDate());
        semester.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        return mapToResponse(semesterRepository.save(semester));
    }

    public void deleteSemester(Integer id) {
        semesterRepository.deleteById(id);
    }

    private SemesterResponse mapToResponse(Semester semester) {
        SemesterResponse response = new SemesterResponse();
        response.setId(semester.getId());
        response.setAcademicYearId(semester.getAcademicYear() != null ? semester.getAcademicYear().getId() : null);
        response.setAcademicYearName(semester.getAcademicYear() != null ? semester.getAcademicYear().getName() : null);
        response.setName(semester.getName());
        response.setStartDate(semester.getStartDate());
        response.setEndDate(semester.getEndDate());
        response.setIsActive(semester.getIsActive());
        return response;
    }
}

