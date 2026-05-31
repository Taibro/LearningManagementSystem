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

    public List<TenantResponse> getAllTenants() {
        List<School> schools = schoolRepository.findAll();
        List<TenantResponse> responses = new ArrayList<>();

        for (School school : schools) {
            TenantResponse tr = mapToTenantResponse(school);
            responses.add(tr);
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
        // 1. Tạo School
        School school = new School();
        school.setName(request.getSchoolName());
        school.setCode(request.getSchoolCode());
        school.setPhone(request.getPhone());
        school.setIsActive(true);

        // Parse school type
        try {
            school.setType(SchoolType.valueOf(request.getSchoolType().toUpperCase()));
        } catch (Exception e) {
            school.setType(SchoolType.OTHER);
        }

        school = schoolRepository.save(school);

        // 2. Tạo User Admin cho trường
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

        // 3. Tạo Subscription
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

        return mapToTenantResponse(school);
    }

    @Transactional
    public void toggleTenantStatus(Integer schoolId, Boolean isActive) {
        School school = schoolRepository.findById(schoolId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy trường với ID: " + schoolId));
        school.setIsActive(isActive);
        schoolRepository.save(school);
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

        // User counts
        long students = userRepository.countBySchoolIdAndRoleName(school.getId(), "STUDENT");
        long teachers = userRepository.countBySchoolIdAndRoleName(school.getId(), "LECTURER");
        tr.setStudents(students);
        tr.setTeachers(teachers);

        // Subscription info
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

        // Storage (placeholder — would integrate with cloud storage API)
        tr.setStorage(String.format("%.1fGB", students * 0.05 + teachers * 0.1));

        return tr;
    }
}
