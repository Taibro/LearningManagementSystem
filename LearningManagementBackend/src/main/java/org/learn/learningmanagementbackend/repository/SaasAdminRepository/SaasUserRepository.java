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

    @Query(value = "SELECT COUNT(u.id) FROM users u " +
            "JOIN user_roles ur ON u.id = ur.user_id " +
            "JOIN role r ON r.id = ur.role_id " +
            "WHERE u.school_id = :schoolId AND UPPER(r.name) = UPPER(:roleName)", nativeQuery = true)
    long countBySchoolIdAndRoleNameNative(@Param("schoolId") Integer schoolId, @Param("roleName") String roleName);

    @Query(value = "SELECT COUNT(u.id) FROM users u " +
            "JOIN user_roles ur ON u.id = ur.user_id " +
            "WHERE u.school_id = :schoolId AND ur.role_id = :roleId", nativeQuery = true)
    long countBySchoolIdAndRoleId(@Param("schoolId") Integer schoolId, @Param("roleId") Integer roleId);
}
