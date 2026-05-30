package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.AcademicYearRequest;
import org.learn.learningmanagementbackend.dto.response.AcademicYearResponse;
import org.learn.learningmanagementbackend.model.AcademicYear;
import org.learn.learningmanagementbackend.model.School;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.AcademicYearRepository;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SchoolRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminAcademicYearService")
@RequiredArgsConstructor
public class AcademicYearService {

    private final AcademicYearRepository academicYearRepository;
    private final SchoolRepository schoolRepository;

    public List<AcademicYearResponse> getAllAcademicYearsBySchool(Integer schoolId) {
        return academicYearRepository.findBySchoolId(schoolId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public AcademicYearResponse getAcademicYearById(Integer id) {
        AcademicYear ay = academicYearRepository.findById(id).orElseThrow(() -> new RuntimeException("Academic Year not found"));
        return mapToResponse(ay);
    }

    public AcademicYearResponse createAcademicYear(AcademicYearRequest request) {
        School school = schoolRepository.findById(request.getSchoolId())
                .orElseThrow(() -> new RuntimeException("School not found"));

        AcademicYear ay = new AcademicYear();
        ay.setSchool(school);
        ay.setName(request.getName());
        ay.setStartDate(request.getStartDate());
        ay.setEndDate(request.getEndDate());
        ay.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        return mapToResponse(academicYearRepository.save(ay));
    }

    public AcademicYearResponse updateAcademicYear(Integer id, AcademicYearRequest request) {
        AcademicYear ay = academicYearRepository.findById(id).orElseThrow(() -> new RuntimeException("Academic Year not found"));

        if (!ay.getSchool().getId().equals(request.getSchoolId())) {
            School school = schoolRepository.findById(request.getSchoolId())
                    .orElseThrow(() -> new RuntimeException("School not found"));
            ay.setSchool(school);
        }

        ay.setName(request.getName());
        ay.setStartDate(request.getStartDate());
        ay.setEndDate(request.getEndDate());
        ay.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        return mapToResponse(academicYearRepository.save(ay));
    }

    public void deleteAcademicYear(Integer id) {
        academicYearRepository.deleteById(id);
    }

    private AcademicYearResponse mapToResponse(AcademicYear ay) {
        AcademicYearResponse response = new AcademicYearResponse();
        response.setId(ay.getId());
        response.setSchoolId(ay.getSchool() != null ? ay.getSchool().getId() : null);
        response.setName(ay.getName());
        response.setStartDate(ay.getStartDate());
        response.setEndDate(ay.getEndDate());
        response.setIsActive(ay.getIsActive());
        return response;
    }
}

