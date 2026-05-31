package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.TeacherRequest;
import org.learn.learningmanagementbackend.dto.response.TeacherResponse;
import org.learn.learningmanagementbackend.model.Department;
import org.learn.learningmanagementbackend.model.Teacher;
import org.learn.learningmanagementbackend.model.Users;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.DepartmentRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.TeacherRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminTeacherService")
@RequiredArgsConstructor
public class TeacherService {

    private final TeacherRepository teacherRepository;
    private final UserRepository userRepository;
    private final DepartmentRepository departmentRepository;

    @org.springframework.beans.factory.annotation.Autowired
    private jakarta.persistence.EntityManager entityManager;

    public List<TeacherResponse> getAllTeachers() {
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!(principal instanceof org.learn.learningmanagementbackend.security.CustomUserDetails)) {
            return java.util.Collections.emptyList();
        }
        Integer userId = ((org.learn.learningmanagementbackend.security.CustomUserDetails) principal).getUserId();

        Integer schoolId;
        try {
            schoolId = entityManager.createQuery("SELECT u.school.id FROM Users u WHERE u.id = :userId", Integer.class)
                    .setParameter("userId", userId).setMaxResults(1).getSingleResult();
        } catch (Exception e) {
            return java.util.Collections.emptyList();
        }

        List<Teacher> teachers = entityManager.createQuery("SELECT t FROM Teacher t WHERE t.department.school.id = :schoolId", Teacher.class)
                .setParameter("schoolId", schoolId).getResultList();

        return teachers.stream().map(TeacherResponse::new).collect(Collectors.toList());
    }

    @Transactional
    public TeacherResponse createTeacher(TeacherRequest request) {
        if (teacherRepository.existsByTeacherCode(request.getTeacherCode())) {
            throw new RuntimeException("Mã giảng viên đã tồn tại");
        }
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email đã tồn tại");
        }
        if (userRepository.existsByCitizenIdNumber(request.getCitizenIdNumber())) {
            throw new RuntimeException("CCCD đã tồn tại");
        }

        Department department = departmentRepository.findById(request.getDepartmentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy khoa"));

        // Tạo User account
        Users user = new Users();
        user.setFullName(request.getFullName());
        user.setEmail(request.getEmail());
        user.setPhone(request.getPhone());
        user.setCitizenIdNumber(request.getCitizenIdNumber());
        user.setGender(request.getGender());
        user.setDateOfBirth(request.getDateOfBirth());
        user.setIsActive(true);
        user.setCode(request.getTeacherCode());
        user.setSchool(department.getSchool());

        Users savedUser = userRepository.save(user);

        // Tạo Teacher profile
        Teacher teacher = new Teacher();
        teacher.setTeacherCode(request.getTeacherCode());
        teacher.setDegree(request.getDegree());
        teacher.setSpecialization(request.getSpecialization());
        teacher.setJoinedDate(request.getJoinedDate());
        teacher.setBio(request.getBio());
        teacher.setDepartment(department);
        
        teacher.setUser(savedUser); // Link Teacher -> User

        Teacher savedTeacher = teacherRepository.save(teacher);
        
        // Link User -> Teacher (Bidirectional)
        savedUser.setTeacher(savedTeacher);
        userRepository.save(savedUser);

        return new TeacherResponse(savedTeacher);
    }

    @Transactional
    public TeacherResponse updateTeacher(Integer id, TeacherRequest request) {
        Teacher teacher = teacherRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy giảng viên"));

        if (teacherRepository.existsByTeacherCodeAndIdNot(request.getTeacherCode(), id)) {
            throw new RuntimeException("Mã giảng viên đã tồn tại");
        }

        Department department = departmentRepository.findById(request.getDepartmentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy khoa"));

        // Update Teacher info
        teacher.setTeacherCode(request.getTeacherCode());
        teacher.setDegree(request.getDegree());
        teacher.setSpecialization(request.getSpecialization());
        teacher.setJoinedDate(request.getJoinedDate());
        teacher.setBio(request.getBio());
        teacher.setDepartment(department);

        // Update User info
        Users user = teacher.getUser();
        user.setFullName(request.getFullName());
        // Bỏ qua update email/CCCD nếu không muốn phức tạp logic check trùng
        user.setPhone(request.getPhone());
        user.setGender(request.getGender());
        user.setDateOfBirth(request.getDateOfBirth());

        userRepository.save(user);
        Teacher savedTeacher = teacherRepository.save(teacher);

        return new TeacherResponse(savedTeacher);
    }

    @Transactional
    public void deleteTeacher(Integer id) {
        Teacher teacher = teacherRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy giảng viên"));
        
        teacherRepository.delete(teacher);
        // Vì CascadeType.ALL, xóa Teacher sẽ không tự xóa User nếu mappedBy nằm ở Teacher?
        // Nhưng trong trường hợp này, mình cần tự xóa User nếu cần thiết.
        // Tạm thời chỉ xóa Teacher, vì theo logic chuẩn thì User vẫn có thể tồn tại nếu họ chuyển role.
    }
}
