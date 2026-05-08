package org.learn.learningmanagementbackend.repository;

import org.learn.learningmanagementbackend.dto.projection.TeacherProfileDto;
import org.learn.learningmanagementbackend.model.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Integer> {

    Optional<Teacher> findByTeacherCode(String code);

    @Query(
            value= """
        SELECT 
            u.fullName AS fullName,
            u.dateOfBirth AS dateOfBirth,
            u.gender AS gender,
            u.email AS email,
            u.phone AS phone,
            u.avatarUrl AS avatarUrl,
            t.teacherCode AS teacherCode,
            t.degree AS degree,
            t.specialization AS specialization,
            d.name AS departmentName,
            u.citizenIdNumber AS citizenIdNumber,
            u.address AS address
        FROM Teacher t
        JOIN t.user u
        JOIN t.department d
        WHERE t.teacherCode = :code
"""
    )
    Optional<TeacherProfileDto> getTeacherProfileByCode(@Param("code") String code);
}
