package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.CourseRequest;
import org.learn.learningmanagementbackend.dto.response.CourseResponse;
import org.learn.learningmanagementbackend.model.Course;
import org.learn.learningmanagementbackend.model.Department;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.CourseRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.DepartmentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CourseService {

    private final CourseRepository courseRepository;
    private final DepartmentRepository departmentRepository;

    public List<CourseResponse> getAllCoursesByDepartment(Integer departmentId) {
        return courseRepository.findByDepartmentId(departmentId).stream()
                .map(CourseResponse::new)
                .collect(Collectors.toList());
    }

    public List<CourseResponse> getAllCourses() {
        return courseRepository.findAll().stream()
                .map(CourseResponse::new)
                .collect(Collectors.toList());
    }

    public CourseResponse createCourse(CourseRequest request) {
        if (courseRepository.existsByCode(request.getCode())) {
            throw new RuntimeException("Mã môn học đã tồn tại");
        }

        Department department = departmentRepository.findById(request.getDepartmentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy khoa"));

        Course course = new Course();
        course.setCode(request.getCode());
        course.setName(request.getName());
        course.setCredits(request.getCredits());
        course.setTheorySessions(request.getTheorySessions());
        course.setPracticalSessions(request.getPracticalSessions());
        course.setTotalSessions(request.getTheorySessions() + request.getPracticalSessions());
        course.setDescription(request.getDescription());
        course.setDepartment(department);
        course.setIsActive(true);

        Course savedCourse = courseRepository.save(course);
        return new CourseResponse(savedCourse);
    }

    public CourseResponse updateCourse(Integer id, CourseRequest request) {
        Course course = courseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy môn học"));

        if (courseRepository.existsByCodeAndIdNot(request.getCode(), id)) {
            throw new RuntimeException("Mã môn học đã tồn tại");
        }

        Department department = departmentRepository.findById(request.getDepartmentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy khoa"));

        course.setCode(request.getCode());
        course.setName(request.getName());
        course.setCredits(request.getCredits());
        course.setTheorySessions(request.getTheorySessions());
        course.setPracticalSessions(request.getPracticalSessions());
        course.setTotalSessions(request.getTheorySessions() + request.getPracticalSessions());
        course.setDescription(request.getDescription());
        course.setDepartment(department);

        Course savedCourse = courseRepository.save(course);
        return new CourseResponse(savedCourse);
    }

    public void deleteCourse(Integer id) {
        Course course = courseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy môn học"));
        
        courseRepository.delete(course);
    }
}
