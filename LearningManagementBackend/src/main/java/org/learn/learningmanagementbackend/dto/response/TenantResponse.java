package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TenantResponse {

    private Integer id;
    private String name;
    private String code;
    private String type;
    private String planName;
    private long students;
    private long teachers;
    private long admins;
    private String storage;
    private String expires;
    private Boolean active;
    private String email;
    private String phone;
    private int daysLeft;
}
