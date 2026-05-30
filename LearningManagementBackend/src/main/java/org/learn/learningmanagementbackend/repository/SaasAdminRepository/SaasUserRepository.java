package org.learn.learningmanagementbackend.repository.SaasAdminRepository;

import org.learn.learningmanagementbackend.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository("saasUserRepository")
public interface SaasUserRepository extends JpaRepository<Users, Integer> {

    long countBySchool_Id(Integer schoolId);

    @Query("SELECT COUNT(u) FROM Users u JOIN u.roles r WHERE r.name = :roleName")
    long countByRoleName(@Param("roleName") String roleName);

    @Query("SELECT COUNT(u) FROM Users u JOIN u.roles r WHERE u.school.id = :schoolId AND r.name = :roleName")
    long countBySchoolIdAndRoleName(@Param("schoolId") Integer schoolId, @Param("roleName") String roleName);
}
