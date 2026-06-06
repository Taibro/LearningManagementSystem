package org.learn.learningmanagementbackend.repository.LecturerRepository;

import org.learn.learningmanagementbackend.dto.projection.TeacherProfileDto;
import org.learn.learningmanagementbackend.model.ScheduleException;
import org.learn.learningmanagementbackend.model.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Integer> {

    Optional<Teacher> findByTeacherCode(String code);

    @Query(
            value = """
                            SELECT 
                                t.id AS id,
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
                                u.address AS address,
                                course.name AS primaryTeachingCourse
                            FROM Teacher t
                            JOIN t.user u
                            LEFT JOIN t.department d
                            LEFT JOIN t.primaryTeachingCourse course
                            WHERE t.teacherCode = :code
                    """
    )
    TeacherProfileDto getTeacherProfileByCode(@Param("code") String code);

    @Query("SELECT t FROM Teacher t JOIN FETCH t.user")
    List<Teacher> findAllTeachersWithUser();

    @Query("SELECT t FROM Teacher t " +
            "JOIN FETCH t.user u " +
            "JOIN FETCH t.department d " +
            "WHERE d.id = :departmentId AND t.teacherCode != :currentTeacherCode " +
            "ORDER BY u.fullName ASC")
    List<Teacher> findColleaguesInSameDepartment(@Param("departmentId") Integer departmentId,
                                                 @Param("currentTeacherCode") String currentTeacherCode);

    // Lấy lịch sử dạy thay
    @Query("SELECT se FROM ScheduleException se " +
            "JOIN FETCH se.schedule s " +
            "JOIN FETCH s.classes c " +
            "JOIN c.teacherLecturings ct " +
            "JOIN ct.teacher t " +
            "WHERE t.teacherCode = :teacherCode " +
            "AND se.exceptionType = 'SUBSTITUTED' " +
            "ORDER BY se.createdAt DESC")
    List<ScheduleException> findSubstituteHistoryByTeacherCode(@Param("teacherCode") String teacherCode);
}
