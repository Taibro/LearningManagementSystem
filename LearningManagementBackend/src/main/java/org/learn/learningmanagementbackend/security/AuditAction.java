package org.learn.learningmanagementbackend.security;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Đánh dấu một phương thức API để tự động ghi Audit Log khi thực thi thành công.
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface AuditAction {
    
    /**
     * Loại hành động: CREATE, UPDATE, DELETE
     */
    String action();

    /**
     * Tên bảng bị tác động (ví dụ: "students", "teachers", "saas_plans")
     */
    String tableName();
}
