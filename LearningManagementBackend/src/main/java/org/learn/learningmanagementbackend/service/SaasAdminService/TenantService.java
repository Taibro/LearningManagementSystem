package org.learn.learningmanagementbackend.service.SaasAdminService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.CreateTenantRequest;
import org.learn.learningmanagementbackend.dto.response.TenantResponse;
import org.learn.learningmanagementbackend.enums.SchoolType;
import org.learn.learningmanagementbackend.model.*;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
@RequiredArgsConstructor
public class TenantService {

    private final SchoolRepository schoolRepository;
    private final SaasUserRepository userRepository;
    private final SaasSubscriptionRepository subscriptionRepository;
    private final SaasPlanRepository planRepository;
    private final PasswordEncoder passwordEncoder;
    private final org.learn.learningmanagementbackend.service.EmailService emailService;

    // Role IDs cố định theo thứ tự insert: 1=SAAS_ADMIN, 2=LECTURER, 3=STUDENT, 4=SCHOOL_ADMIN
    private static final int ROLE_ID_LECTURER = 2;
    private static final int ROLE_ID_STUDENT = 3;
    private static final int ROLE_ID_SCHOOL_ADMIN = 4;

    public List<TenantResponse> getAllTenants() {
        List<School> schools = schoolRepository.findAll();
        List<TenantResponse> responses = new ArrayList<>();
        for (School school : schools) {
            responses.add(mapToTenantResponse(school));
        }
        return responses;
    }

    public TenantResponse getTenantDetail(Integer schoolId) {
        School school = schoolRepository.findById(schoolId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy trường với ID: " + schoolId));
        return mapToTenantResponse(school);
    }

    @Transactional
    public TenantResponse createTenant(CreateTenantRequest request) {
        School school = new School();
        school.setName(request.getSchoolName());
        school.setCode(request.getSchoolCode());
        school.setPhone(request.getPhone());
        school.setIsActive(true);

        try {
            school.setType(SchoolType.valueOf(request.getSchoolType().toUpperCase()));
        } catch (Exception e) {
            school.setType(SchoolType.OTHER);
        }

        school = schoolRepository.save(school);

        Users adminUser = new Users();
        adminUser.setSchool(school);
        adminUser.setCode("ADM-" + request.getSchoolCode() + "-01");
        adminUser.setCitizenIdNumber("079" + String.format("%09d", new Random().nextInt(999999999)));
        adminUser.setFullName(request.getAdminName() != null ? request.getAdminName() : "Admin " + request.getSchoolName());
        adminUser.setEmail(request.getAdminEmail());
        adminUser.setPasswordHash(passwordEncoder.encode("123456"));
        adminUser.setIsActive(true);

        school.addUser(adminUser);
        schoolRepository.save(school);

        SaasPlan plan = planRepository.findById(request.getPlanId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy gói cước với ID: " + request.getPlanId()));

        SaasSubscription subscription = new SaasSubscription();
        subscription.setSchool(school);
        subscription.setPlan(plan);
        subscription.setStartDate(LocalDate.now());
        subscription.setBillingCycle(request.getBillingCycle() != null ? request.getBillingCycle().toUpperCase() : "MONTHLY");

        if ("YEARLY".equalsIgnoreCase(request.getBillingCycle())) {
            subscription.setEndDate(LocalDate.now().plusYears(1));
        } else {
            subscription.setEndDate(LocalDate.now().plusMonths(1));
        }
        subscription.setStatus("ACTIVE");
        subscriptionRepository.save(subscription);

        // Gửi email thông báo cho School Admin
        emailService.sendTenantWelcomeEmail(
            adminUser.getEmail(), 
            school.getName(), 
            adminUser.getFullName(), 
            "Admin@123", 
            "http://localhost:5173/login" // Link đến Frontend của School Admin
        );

        return mapToTenantResponse(school);
    }

    @Transactional
    public void toggleTenantStatus(Integer schoolId, Boolean isActive) {
        School school = schoolRepository.findById(schoolId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy trường với ID: " + schoolId));
        school.setIsActive(isActive);
        schoolRepository.save(school);
    }

    @Transactional
    public TenantResponse updateTenant(Integer schoolId, Map<String, Object> updates) {
        School school = schoolRepository.findById(schoolId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy trường với ID: " + schoolId));

        if (updates.containsKey("name") && updates.get("name") != null) {
            school.setName(updates.get("name").toString());
        }
        if (updates.containsKey("phone")) {
            school.setPhone(updates.get("phone") != null ? updates.get("phone").toString() : null);
        }
        schoolRepository.save(school);

        // Gia hạn hoặc đặt ngày hết hạn mới
        if (updates.containsKey("extendMonths") || updates.containsKey("extendYears") || updates.containsKey("newEndDate")) {
            Optional<SaasSubscription> activeSubOpt = subscriptionRepository.findBySchool_IdAndStatus(schoolId, "ACTIVE");
            if (activeSubOpt.isPresent()) {
                SaasSubscription sub = activeSubOpt.get();
                LocalDate baseDate = sub.getEndDate().isAfter(LocalDate.now()) ? sub.getEndDate() : LocalDate.now();

                if (updates.containsKey("newEndDate") && updates.get("newEndDate") != null) {
                    sub.setEndDate(LocalDate.parse(updates.get("newEndDate").toString()));
                } else if (updates.containsKey("extendYears")) {
                    sub.setEndDate(baseDate.plusYears(Integer.parseInt(updates.get("extendYears").toString())));
                } else if (updates.containsKey("extendMonths")) {
                    sub.setEndDate(baseDate.plusMonths(Integer.parseInt(updates.get("extendMonths").toString())));
                }
                sub.setStatus("ACTIVE");
                subscriptionRepository.save(sub);
            }
        }

        // Đổi gói cước
        if (updates.containsKey("planId") && updates.get("planId") != null) {
            Integer newPlanId = Integer.parseInt(updates.get("planId").toString());
            SaasPlan newPlan = planRepository.findById(newPlanId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy gói cước với ID: " + newPlanId));
            Optional<SaasSubscription> activeSubOpt = subscriptionRepository.findBySchool_IdAndStatus(schoolId, "ACTIVE");
            if (activeSubOpt.isPresent()) {
                activeSubOpt.get().setPlan(newPlan);
                subscriptionRepository.save(activeSubOpt.get());
            }
        }

        return mapToTenantResponse(school);
    }

    private TenantResponse mapToTenantResponse(School school) {
        TenantResponse tr = new TenantResponse();
        tr.setId(school.getId());
        tr.setName(school.getName());
        tr.setCode(school.getCode());
        tr.setType(school.getType() != null ? school.getType().name().toLowerCase() : "other");
        tr.setActive(school.getIsActive() != null ? school.getIsActive() : true);
        tr.setEmail(school.getEmail());
        tr.setPhone(school.getPhone());

        // Đếm user theo role_id (tránh vấn đề case-sensitive)
        long students = userRepository.countBySchoolIdAndRoleId(school.getId(), ROLE_ID_STUDENT);
        long teachers = userRepository.countBySchoolIdAndRoleId(school.getId(), ROLE_ID_LECTURER);
        long admins = userRepository.countBySchoolIdAndRoleId(school.getId(), ROLE_ID_SCHOOL_ADMIN);
        tr.setStudents(students);
        tr.setTeachers(teachers);
        tr.setAdmins(admins);

        // Thông tin gói cước
        Optional<SaasSubscription> activeSub = subscriptionRepository.findBySchool_IdAndStatus(school.getId(), "ACTIVE");
        if (activeSub.isPresent()) {
            SaasSubscription sub = activeSub.get();
            tr.setPlanName(sub.getPlan().getName());
            tr.setExpires(sub.getEndDate().format(DateTimeFormatter.ISO_LOCAL_DATE));
            tr.setDaysLeft((int) ChronoUnit.DAYS.between(LocalDate.now(), sub.getEndDate()));
        } else {
            tr.setPlanName("Không có");
            tr.setExpires("-");
            tr.setDaysLeft(0);
        }

        // Storage (placeholder)
        tr.setStorage(String.format("%.1fGB", students * 0.05 + teachers * 0.1 + admins * 0.01));

        return tr;
    }
}
