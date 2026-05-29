package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.ClassRequest;
import org.learn.learningmanagementbackend.dto.response.ClassResponse;
import org.learn.learningmanagementbackend.model.Classes;
import org.learn.learningmanagementbackend.model.Course;
import org.learn.learningmanagementbackend.model.Semester;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.ClassesRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.CourseRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.SemesterRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminClassesService")
@RequiredArgsConstructor
public class ClassesService {

    private final ClassesRepository classesRepository;
    private final CourseRepository courseRepository;
    private final SemesterRepository semesterRepository;

    public List<ClassResponse> getAllClasses() {
        return classesRepository.findAll().stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public ClassResponse getClassById(Integer id) {
        Classes classes = classesRepository.findById(id).orElseThrow(() -> new RuntimeException("Class not found"));
        return mapToResponse(classes);
    }

    public ClassResponse createClass(ClassRequest request) {
        Course course = courseRepository.findById(request.getCourseId())
                .orElseThrow(() -> new RuntimeException("Course not found"));
        Semester semester = semesterRepository.findById(request.getSemesterId())
                .orElseThrow(() -> new RuntimeException("Semester not found"));

        Classes classes = new Classes();
        classes.setCode(request.getCode());
        classes.setCourse(course);
        classes.setSemester(semester);
        classes.setMaxStudents(request.getMaxStudents() != null ? request.getMaxStudents() : 40);
        classes.setStatus(request.getStatus());
        classes.setNotes(request.getNotes());

        return mapToResponse(classesRepository.save(classes));
    }

    public ClassResponse updateClass(Integer id, ClassRequest request) {
        Classes classes = classesRepository.findById(id).orElseThrow(() -> new RuntimeException("Class not found"));

        if (!classes.getCourse().getId().equals(request.getCourseId())) {
            Course course = courseRepository.findById(request.getCourseId())
                    .orElseThrow(() -> new RuntimeException("Course not found"));
            classes.setCourse(course);
        }

        if (!classes.getSemester().getId().equals(request.getSemesterId())) {
            Semester semester = semesterRepository.findById(request.getSemesterId())
                    .orElseThrow(() -> new RuntimeException("Semester not found"));
            classes.setSemester(semester);
        }

        classes.setCode(request.getCode());
        classes.setMaxStudents(request.getMaxStudents() != null ? request.getMaxStudents() : 40);
        classes.setStatus(request.getStatus());
        classes.setNotes(request.getNotes());

        return mapToResponse(classesRepository.save(classes));
    }

    public void deleteClass(Integer id) {
        classesRepository.deleteById(id);
    }

    private ClassResponse mapToResponse(Classes classes) {
        ClassResponse response = new ClassResponse();
        response.setId(classes.getId());
        response.setCode(classes.getCode());
        
        if (classes.getCourse() != null) {
            response.setCourseId(classes.getCourse().getId());
            response.setCourseName(classes.getCourse().getName());
        }
        
        if (classes.getSemester() != null) {
            response.setSemesterId(classes.getSemester().getId());
            response.setSemesterName(classes.getSemester().getName());
        }
        
        response.setMaxStudents(classes.getMaxStudents());
        response.setStatus(classes.getStatus());
        response.setNotes(classes.getNotes());
        
        // Count enrolled students securely
        int enrolled = 0;
        if (classes.getEnrollments() != null) {
            enrolled = (int) classes.getEnrollments().stream()
                .filter(e -> "ENROLLED".equals(e.getStatus().name()))
                .count();
        }
        response.setEnrolledStudents(enrolled);
        
        // Map teachers if any
        if (classes.getTeacherLecturings() != null) {
            response.setTeachers(classes.getTeacherLecturings().stream()
                .filter(ct -> ct.getTeacher() != null && ct.getTeacher().getUser() != null)
                .map(ct -> ct.getRole() + ": " + ct.getTeacher().getUser().getFullName())
                .collect(Collectors.toList()));
        }
        
        return response;
    }
}
