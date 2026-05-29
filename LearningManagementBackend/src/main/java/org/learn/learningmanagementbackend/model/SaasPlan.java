package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "saas_plans")
public class SaasPlan extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "code", length = 50, nullable = false, unique = true)
    private String code;

    @Column(name = "name", length = 100, nullable = false)
    private String name;

    @Column(name = "monthly_price", nullable = false)
    private BigDecimal monthlyPrice;

    @Column(name = "yearly_price", nullable = false)
    private BigDecimal yearlyPrice;

    @Column(name = "max_students", nullable = false)
    private Integer maxStudents;

    @Column(name = "max_storage_gb", nullable = false)
    private Integer maxStorageGb;

    @Column(name = "features", columnDefinition = "JSON")
    private String features;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;
}
