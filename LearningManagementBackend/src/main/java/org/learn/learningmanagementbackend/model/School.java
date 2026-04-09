package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.SchoolType;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "School")
public class School {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "code", nullable = false, length = 30)
    private String code;

    @Column(name = "name", nullable = false)
    private String  name;

    @Column(name = "short_name", length = 50)
    private String short_name;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private SchoolType type;

    @Column(name = "accreditation", length = 100)
    private String accreditation;

    @Column(name = "tax_code", length = 20)
    private String tax_code;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "website", length = 255)
    private String website;

    @Column(name = "logo_url", length = 500)
    private String logo_url;

    @Column(name = "established_date")
    private LocalDate established_date;

    @Column(name = "description")
    private String description;

    @Column(name = "is_active")
    private Boolean is_active;


}
