package org.learn.learningmanagementbackend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Embeddable
@Getter
@Setter
@EqualsAndHashCode
public class UserSchoolId implements Serializable {

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "school_id")
    private Integer schoolId;

    @Column(name = "role_id")
    private Integer roleId;
}
