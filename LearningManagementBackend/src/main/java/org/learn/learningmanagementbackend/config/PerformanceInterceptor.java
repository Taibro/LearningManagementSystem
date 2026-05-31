package org.learn.learningmanagementbackend.config;

import org.learn.learningmanagementbackend.service.SystemHealthMetrics;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class PerformanceInterceptor implements HandlerInterceptor {
    private final SystemHealthMetrics metrics;
    
    public PerformanceInterceptor(SystemHealthMetrics metrics) {
        this.metrics = metrics;
    }
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        request.setAttribute("startTime", System.currentTimeMillis());
        metrics.recordRequestStart();
        return true;
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        Long startTime = (Long) request.getAttribute("startTime");
        if (startTime != null) {
            metrics.recordRequestEnd(System.currentTimeMillis() - startTime);
        }
    }
}
