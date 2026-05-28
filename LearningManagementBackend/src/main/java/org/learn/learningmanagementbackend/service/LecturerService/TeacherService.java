package org.learn.learningmanagementbackend.service.LecturerService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.TeacherProfileDto;
import org.learn.learningmanagementbackend.dto.request.TeacherProfileUpdateDto;
import org.learn.learningmanagementbackend.enums.Gender;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.LecturerRepository.TeacherRepository;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TeacherService {

    private final TeacherRepository teacherRepository;

    public TeacherProfileDto getTeacherProfileByCode(String code) {
        return teacherRepository.getTeacherProfileByCode(code);
    }

    @Transactional
    public void updateTeacherProfile(String teacherCode, TeacherProfileUpdateDto dto) {
        Teacher teacher = teacherRepository.findByTeacherCode(teacherCode)
                .orElseThrow(() -> new RuntimeException("Khong tim thay thong tin giang vien"));

        teacher.setDegree(dto.getDegree());
        teacher.setSpecialization(dto.getSpecialization());

        Users user = teacher.getUser();
        user.setFullName(dto.getFullName());
        user.setDateOfBirth(dto.getDateOfBirth());
        user.setGender(Gender.valueOf(dto.getGender()));
        user.setPhone(dto.getPhone());
        user.setCitizenIdNumber(dto.getCitizenIdNumber());
        user.setAddress(dto.getAddress());

        // @Transactional tu dong luu
//        teacherRepository.save(teacher);
    }
}
