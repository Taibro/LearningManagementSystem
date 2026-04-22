package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.SchoolType;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "School")
public class School extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "code", nullable = false, length = 30)
    private String code;

    @Column(name = "name", nullable = false)
    private String  name;

    @Column(name = "short_name", length = 50)
    private String shortName;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private SchoolType type;

    @Column(name = "accreditation", length = 100)
    private String accreditation;

    @Column(name = "tax_code", length = 20)
    private String taxCode;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "website", length = 255)
    private String website;

    @Column(name = "logo_url", length = 500)
    private String logoUrl;

    @Column(name = "established_date")
    private LocalDate establishedDate;

    @Column(name = "description")
    private String description;

    @Column(name = "is_active")
    private Boolean isActive;

    @OneToMany(mappedBy = "school", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserSchool> userSchools = new ArrayList<>();

    public void addUserSchool(UserSchool userSchool){
        this.userSchools.add(userSchool);
        userSchool.setSchool(this);
    }

    public void removeUserSchool(UserSchool userSchool){
        this.userSchools.remove(userSchool);
        userSchool.setSchool(null);
    }

    @OneToMany(mappedBy = "school", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<SchoolBranch> schoolBranches = new ArrayList<>();

    @OneToMany(mappedBy = "school", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<AcademicYear> academicYears = new ArrayList<>();

    @OneToMany(mappedBy = "school", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    private List<Department> departments = new ArrayList<>();
}
