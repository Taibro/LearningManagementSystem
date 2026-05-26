package org.learn.learningmanagementbackend.service;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.TeacherDeclarationRequest;
import org.learn.learningmanagementbackend.model.Semester;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.model.TeacherDeclaration;
import org.learn.learningmanagementbackend.repository.SemesterRepository;
import org.learn.learningmanagementbackend.repository.TeacherDeclarationRepository;
import org.learn.learningmanagementbackend.repository.TeacherRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class TeacherDeclarationService {

    private final TeacherDeclarationRepository declarationRepository;
    private final TeacherRepository teacherRepository;
    private final SemesterRepository semesterRepository;

    @Transactional(rollbackFor = Exception.class)
    public void saveDeclaration(TeacherDeclarationRequest request) {

        TeacherDeclaration declaration = declarationRepository
                .findByTeacherIdAndSemesterId(request.getTeacherId(), request.getSemesterId())
                .orElse(new TeacherDeclaration());

        Teacher teacherRef = teacherRepository.getReferenceById(request.getTeacherId());
        Semester semesterRef = semesterRepository.getReferenceById(request.getSemesterId());

        declaration.setTeacher(teacherRef);
        declaration.setSemester(semesterRef);
        declaration.setExpectedSessions(request.getExpectedSessions());
        declaration.setExpectedClasses(request.getExpectedClasses());
        declaration.setNotes(request.getNotes());

        declarationRepository.save(declaration);
    }
}