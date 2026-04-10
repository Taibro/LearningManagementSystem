package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "Role")
@NoArgsConstructor
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @OneToMany(mappedBy = "role", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserSchool> userSchools = new ArrayList<>();

    public void addUserSchool(UserSchool userSchool){
        this.userSchools.add(userSchool);
        userSchool.setRole(this);
    }

    public void removeUserSchool(UserSchool userSchool){
        this.userSchools.remove(userSchool);
        userSchool.setRole(null);
    }
}
