package org.learn.learningmanagementbackend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Embeddable
public class ClassTeacherId implements Serializable {

    @Column(name = "class_id")
    private Integer classId;

    @Column(name = "teacher_id")
    private Integer teacherId;
}
