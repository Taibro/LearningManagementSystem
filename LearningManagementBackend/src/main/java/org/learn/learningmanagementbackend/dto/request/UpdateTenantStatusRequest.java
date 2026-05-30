package org.learn.learningmanagementbackend.dto.request;

import lombok.Data;

@Data
public class UpdateTenantStatusRequest {
    private Boolean isActive;
}
