package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.projection.MonthlySalaryDto;
import org.learn.learningmanagementbackend.repository.LecturerRepository.TeacherSalarySheetRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TeacherSalarySheetService {

    private final TeacherSalarySheetRepository teacherSalarySheetRepository;

    public Optional<MonthlySalaryDto> getSalaryByMonthAndYear(
            String teacherCode,
            Integer year,
            Integer month
    ) {
        return teacherSalarySheetRepository.getSalaryByMonthAndYear(teacherCode, year, month);
    }

}
