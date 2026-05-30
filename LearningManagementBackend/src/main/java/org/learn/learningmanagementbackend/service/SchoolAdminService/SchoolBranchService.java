package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SchoolBranchRequest;
import org.learn.learningmanagementbackend.dto.response.SchoolBranchResponse;
import org.learn.learningmanagementbackend.model.School;
import org.learn.learningmanagementbackend.model.SchoolBranch;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.SchoolBranchRepository;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SchoolRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminSchoolBranchService")
@RequiredArgsConstructor
public class SchoolBranchService {

    private final SchoolBranchRepository branchRepository;
    private final SchoolRepository schoolRepository;

    public List<SchoolBranchResponse> getAllBranchesBySchool(Integer schoolId) {
        return branchRepository.findBySchoolId(schoolId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public SchoolBranchResponse getBranchById(Integer id) {
        SchoolBranch branch = branchRepository.findById(id).orElseThrow(() -> new RuntimeException("Branch not found"));
        return mapToResponse(branch);
    }

    public SchoolBranchResponse createBranch(SchoolBranchRequest request) {
        School school = schoolRepository.findById(request.getSchoolId())
                .orElseThrow(() -> new RuntimeException("School not found"));

        SchoolBranch branch = new SchoolBranch();
        branch.setSchool(school);
        branch.setCode(request.getCode());
        branch.setName(request.getName());
        branch.setAddress(request.getAddress());
        branch.setCity(request.getCity());
        branch.setDistrict(request.getDistrict());
        branch.setPhone(request.getPhone());
        branch.setEmail(request.getEmail());
        branch.setIsMain(request.getIsMain() != null ? request.getIsMain() : false);
        branch.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        return mapToResponse(branchRepository.save(branch));
    }

    public SchoolBranchResponse updateBranch(Integer id, SchoolBranchRequest request) {
        SchoolBranch branch = branchRepository.findById(id).orElseThrow(() -> new RuntimeException("Branch not found"));

        if (!branch.getSchool().getId().equals(request.getSchoolId())) {
            School school = schoolRepository.findById(request.getSchoolId())
                    .orElseThrow(() -> new RuntimeException("School not found"));
            branch.setSchool(school);
        }

        branch.setCode(request.getCode());
        branch.setName(request.getName());
        branch.setAddress(request.getAddress());
        branch.setCity(request.getCity());
        branch.setDistrict(request.getDistrict());
        branch.setPhone(request.getPhone());
        branch.setEmail(request.getEmail());
        branch.setIsMain(request.getIsMain() != null ? request.getIsMain() : false);
        branch.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        return mapToResponse(branchRepository.save(branch));
    }

    public void deleteBranch(Integer id) {
        branchRepository.deleteById(id);
    }

    private SchoolBranchResponse mapToResponse(SchoolBranch branch) {
        SchoolBranchResponse response = new SchoolBranchResponse();
        response.setId(branch.getId());
        response.setSchoolId(branch.getSchool() != null ? branch.getSchool().getId() : null);
        response.setSchoolName(branch.getSchool() != null ? branch.getSchool().getName() : null);
        response.setCode(branch.getCode());
        response.setName(branch.getName());
        response.setAddress(branch.getAddress());
        response.setCity(branch.getCity());
        response.setDistrict(branch.getDistrict());
        response.setPhone(branch.getPhone());
        response.setEmail(branch.getEmail());
        response.setIsMain(branch.getIsMain());
        response.setIsActive(branch.getIsActive());
        return response;
    }
}

