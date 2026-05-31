package org.learn.learningmanagementbackend.exception;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.model.SystemErrorLog;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SystemErrorLogRepository;
import org.learn.learningmanagementbackend.security.CustomUserDetails;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Map;

@RestControllerAdvice
@RequiredArgsConstructor
public class GlobalExceptionHandler {

    private final SystemErrorLogRepository errorLogRepository;

    // ──── Helper: Ghi error log vào DB ────
    private void saveErrorLog(HttpServletRequest request, Exception ex) {
        try {
            SystemErrorLog log = new SystemErrorLog();

            // Endpoint (method + URI)
            String endpoint = request.getMethod() + " " + request.getRequestURI();
            log.setEndpoint(endpoint);

            // Error message
            log.setErrorMessage(ex.getMessage() != null ? ex.getMessage() : ex.getClass().getSimpleName());

            // Stack trace (giới hạn 5000 ký tự để tránh quá lớn)
            StringWriter sw = new StringWriter();
            ex.printStackTrace(new PrintWriter(sw));
            String stackTrace = sw.toString();
            if (stackTrace.length() > 5000) {
                stackTrace = stackTrace.substring(0, 5000) + "\n... [TRUNCATED]";
            }
            log.setStackTrace(stackTrace);

            // User-Agent
            String userAgent = request.getHeader("User-Agent");
            log.setUserAgent(userAgent);

            // School (nếu user đã đăng nhập và thuộc về 1 trường)
            try {
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                if (auth != null && auth.getPrincipal() instanceof CustomUserDetails) {
                    CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
                    // School sẽ để null — error log ghi nhận ở system-level
                    // Có thể mở rộng: dùng EntityManager để lookup school_id từ userId nếu cần
                }
            } catch (Exception ignored) {
                // Không được để lỗi ghi log gây crash hệ thống
            }

            log.setIsResolved(false);

            errorLogRepository.save(log);
        } catch (Exception ignored) {
            // Tuyệt đối KHÔNG để lỗi ghi log gây ra thêm lỗi
            System.err.println("[ERROR LOG FAILED] " + ignored.getMessage());
        }
    }

    // ──── Xử lý lỗi đăng nhập sai ────
    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<Map<String, String>> handleBadCredentials(BadCredentialsException ex, HttpServletRequest request) {
        saveErrorLog(request, ex);
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("message", "Tài khoản hoặc mật khẩu không chính xác"));
    }

    // ──── Xử lý lỗi vi phạm ràng buộc DB (duplicate key, FK constraint...) ────
    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<Map<String, String>> handleDataIntegrity(DataIntegrityViolationException ex, HttpServletRequest request) {
        saveErrorLog(request, ex);
        String msg = ex.getMostSpecificCause().getMessage();
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(Map.of("message", "Lỗi dữ liệu: " + msg));
    }

    // ──── Xử lý RuntimeException (validation, business logic...) ────
    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<Map<String, String>> handleRunTime(RuntimeException ex, HttpServletRequest request) {
        saveErrorLog(request, ex);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(Map.of("message", ex.getMessage()));
    }

    // ──── Xử lý tất cả Exception còn lại (catch-all) ────
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, String>> handleAll(Exception ex, HttpServletRequest request) {
        saveErrorLog(request, ex);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("message", "Lỗi hệ thống: " + ex.getMessage()));
    }
}
