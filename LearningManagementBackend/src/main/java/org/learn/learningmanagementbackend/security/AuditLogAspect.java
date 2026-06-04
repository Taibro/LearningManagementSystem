package org.learn.learningmanagementbackend.security;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.learn.learningmanagementbackend.model.AuditLog;
import org.learn.learningmanagementbackend.model.School;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.AuditLogRepository;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SchoolRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.HandlerMapping;

import java.lang.reflect.Method;
import java.util.Map;

@Aspect
@Component
@RequiredArgsConstructor
public class AuditLogAspect {

    private final AuditLogRepository auditLogRepository;
    private final SchoolRepository schoolRepository;

    @AfterReturning(pointcut = "@annotation(auditAction)", returning = "result")
    public void logAuditAction(JoinPoint joinPoint, AuditAction auditAction, Object result) {
        try {
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            if (authentication == null || !(authentication.getPrincipal() instanceof CustomUserDetails)) {
                return; // Không ghi log nếu không xác định được người dùng
            }

            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            
            AuditLog log = new AuditLog();
            log.setUserEmail(userDetails.getEmail());
            log.setAction(auditAction.action().toUpperCase());
            log.setTableName(auditAction.tableName());
            
            String ipAddress = request.getHeader("X-Forwarded-For");
            if (ipAddress == null || ipAddress.isEmpty()) {
                ipAddress = request.getRemoteAddr();
            }
            log.setIpAddress(ipAddress);

            // Xử lý School
            if (userDetails.getSchoolId() != null) {
                School school = schoolRepository.findById(userDetails.getSchoolId()).orElse(null);
                log.setSchool(school);
            }

            // Xử lý Record ID
            Long recordId = extractRecordId(request, result);
            log.setRecordId(recordId);

            auditLogRepository.save(log);

        } catch (Exception e) {
            // Không bao giờ để lỗi AuditLog làm ảnh hưởng đến luồng chính
            System.err.println("[AUDIT LOG FAILED] " + e.getMessage());
        }
    }

    private Long extractRecordId(HttpServletRequest request, Object result) {
        Long recordId = null;

        // 1. Thử lấy từ Path Variable (Thường dùng cho UPDATE, DELETE)
        try {
            @SuppressWarnings("unchecked")
            Map<String, String> pathVariables = (Map<String, String>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
            if (pathVariables != null) {
                if (pathVariables.containsKey("id")) {
                    recordId = Long.parseLong(pathVariables.get("id"));
                } else if (pathVariables.containsKey("studentId")) {
                    recordId = Long.parseLong(pathVariables.get("studentId"));
                } else if (pathVariables.containsKey("teacherId")) {
                    recordId = Long.parseLong(pathVariables.get("teacherId"));
                } else if (pathVariables.containsKey("planId")) {
                    recordId = Long.parseLong(pathVariables.get("planId"));
                }
            }
        } catch (Exception ignored) {}

        // 2. Nếu chưa có, thử lấy từ Object trả về (Thường dùng cho CREATE)
        if (recordId == null && result != null) {
            try {
                Object body = result;
                if (result instanceof ResponseEntity) {
                    body = ((ResponseEntity<?>) result).getBody();
                }
                
                if (body != null) {
                    Method getIdMethod = body.getClass().getMethod("getId");
                    Object idVal = getIdMethod.invoke(body);
                    if (idVal instanceof Number) {
                        recordId = ((Number) idVal).longValue();
                    }
                }
            } catch (Exception ignored) {}
        }

        return recordId;
    }
}
