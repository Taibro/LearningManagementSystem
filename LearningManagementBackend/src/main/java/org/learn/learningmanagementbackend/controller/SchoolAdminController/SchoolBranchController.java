package org.learn.learningmanagementbackend.controller.SchoolAdminController;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SchoolBranchRequest;
import org.learn.learningmanagementbackend.dto.response.SchoolBranchResponse;
import org.learn.learningmanagementbackend.service.SchoolAdminService.SchoolBranchService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("schoolAdminSchoolBranchController")
@RequestMapping("/api/school-admin/branches")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class SchoolBranchController {

    private final SchoolBranchService branchService;

    @GetMapping("/school/{schoolId}")
    public ResponseEntity<List<SchoolBranchResponse>> getAllBranches(@PathVariable Integer schoolId) {
        return ResponseEntity.ok(branchService.getAllBranchesBySchool(schoolId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<SchoolBranchResponse> getBranchById(@PathVariable Integer id) {
        return ResponseEntity.ok(branchService.getBranchById(id));
    }

    @PostMapping
    public ResponseEntity<SchoolBranchResponse> createBranch(@RequestBody SchoolBranchRequest request) {
        return ResponseEntity.ok(branchService.createBranch(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<SchoolBranchResponse> updateBranch(@PathVariable Integer id, @RequestBody SchoolBranchRequest request) {
        return ResponseEntity.ok(branchService.updateBranch(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBranch(@PathVariable Integer id) {
        branchService.deleteBranch(id);
        return ResponseEntity.noContent().build();
    }
}
