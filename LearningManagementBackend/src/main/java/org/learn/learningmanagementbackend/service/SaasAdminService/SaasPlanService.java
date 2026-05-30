package org.learn.learningmanagementbackend.service.SaasAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.SaasPlanRequest;
import org.learn.learningmanagementbackend.dto.response.SaasPlanResponse;
import org.learn.learningmanagementbackend.model.SaasPlan;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SaasPlanRepository;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SaasSubscriptionRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SaasPlanService {

    private final SaasPlanRepository planRepository;
    private final SaasSubscriptionRepository subscriptionRepository;

    public List<SaasPlanResponse> getAllPlans() {
        List<SaasPlan> plans = planRepository.findAll();

        // Đếm subscriber cho từng plan
        Map<String, Long> subscriberCounts = subscriptionRepository.countActiveSubscriptionsByPlan()
                .stream()
                .collect(Collectors.toMap(
                        row -> (String) row[0],
                        row -> (Long) row[1]
                ));

        List<SaasPlanResponse> responses = new ArrayList<>();
        for (SaasPlan plan : plans) {
            SaasPlanResponse pr = mapToResponse(plan);
            pr.setSubscriberCount(subscriberCounts.getOrDefault(plan.getName(), 0L));
            responses.add(pr);
        }
        return responses;
    }

    public SaasPlanResponse createPlan(SaasPlanRequest request) {
        SaasPlan plan = new SaasPlan();
        plan.setCode(request.getCode());
        plan.setName(request.getName());
        plan.setMonthlyPrice(request.getMonthlyPrice());
        plan.setYearlyPrice(request.getYearlyPrice());
        plan.setMaxStudents(request.getMaxStudents());
        plan.setMaxStorageGb(request.getMaxStorageGb());
        plan.setFeatures(request.getFeatures());
        plan.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        plan = planRepository.save(plan);
        return mapToResponse(plan);
    }

    public SaasPlanResponse updatePlan(Integer planId, SaasPlanRequest request) {
        SaasPlan plan = planRepository.findById(planId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy gói cước với ID: " + planId));

        if (request.getCode() != null) plan.setCode(request.getCode());
        if (request.getName() != null) plan.setName(request.getName());
        if (request.getMonthlyPrice() != null) plan.setMonthlyPrice(request.getMonthlyPrice());
        if (request.getYearlyPrice() != null) plan.setYearlyPrice(request.getYearlyPrice());
        if (request.getMaxStudents() != null) plan.setMaxStudents(request.getMaxStudents());
        if (request.getMaxStorageGb() != null) plan.setMaxStorageGb(request.getMaxStorageGb());
        if (request.getFeatures() != null) plan.setFeatures(request.getFeatures());
        if (request.getIsActive() != null) plan.setIsActive(request.getIsActive());

        plan = planRepository.save(plan);
        return mapToResponse(plan);
    }

    private SaasPlanResponse mapToResponse(SaasPlan plan) {
        SaasPlanResponse pr = new SaasPlanResponse();
        pr.setId(plan.getId());
        pr.setCode(plan.getCode());
        pr.setName(plan.getName());
        pr.setMonthlyPrice(plan.getMonthlyPrice());
        pr.setYearlyPrice(plan.getYearlyPrice());
        pr.setMaxStudents(plan.getMaxStudents());
        pr.setMaxStorageGb(plan.getMaxStorageGb());
        pr.setFeatures(plan.getFeatures());
        pr.setIsActive(plan.getIsActive());
        return pr;
    }
}
