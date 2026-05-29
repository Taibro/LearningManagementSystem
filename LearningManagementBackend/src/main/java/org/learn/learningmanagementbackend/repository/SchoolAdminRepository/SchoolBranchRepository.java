package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.SchoolBranch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository("schoolAdminSchoolBranchRepository")
public interface SchoolBranchRepository extends JpaRepository<SchoolBranch, Integer> {
    List<SchoolBranch> findBySchoolId(Integer schoolId);
    Optional<SchoolBranch> findByCodeAndSchoolId(String code, Integer schoolId);
}
