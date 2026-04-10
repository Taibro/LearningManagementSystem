package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "School_branches")
public class SchoolBranch extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "school_id")
    private School school;

    @Column(name = "code", length = 20)
    private String code;

    @Column(name = "name", length = 150)
    private String name;

    @Column(name = "address", length=300)
    private String address;

    @Column(name = "City", length = 100)
    private String City;

    @Column(name = "district", length = 100)
    private String district;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name ="is_main")
    private Boolean isMain;

    @Column(name = "is_active")
    private Boolean isActive;

    @OneToMany(mappedBy = "schoolBranch", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Room> rooms = new ArrayList<>();
}
