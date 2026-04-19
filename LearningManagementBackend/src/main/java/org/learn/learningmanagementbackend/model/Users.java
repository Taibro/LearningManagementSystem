package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.UpdateTimestamp;
import org.learn.learningmanagementbackend.enums.Gender;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Users")
public class Users extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "full_name", length = 100)
    private String fullName;

    @NotBlank(message = "Email không được để trống")
    @Email(
            regexp = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$",
            message = "Email sai định dạng (bắt buộc phải có đuôi .com, .vn...)"
    )
    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "password_hash", length = 255)
    private String passwordHash;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender")
    private Gender gender;

    @Column(name = "avatar_url", length = 500)
    private String avatarUrl;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "last_login_at")
    private LocalDateTime lastLoginAt;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserSchool> userSchools = new ArrayList<>();

    public void addUserSchool(UserSchool userSchool){
        this.userSchools.add(userSchool);
        userSchool.setUser(this);
    }

    public void removeUserSchool(UserSchool userSchool){
        this.userSchools.remove(userSchool);
        userSchool.setUser(null);
    }

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private Teacher teacher;

    // Set teacher cho user
    public void setTeacherProfile(Teacher teacher) {
        if (teacher == null) {
            if (this.teacher != null) {
                this.teacher.setUser(null);
            }
        } else {
            teacher.setUser(this);
        }
        this.teacher = teacher;
    }

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private Student student;

    // Set student cho user
    public void setStudentProfile(Student student) {
        if (student == null) {
            if (this.student != null) {
                this.student.setUser(null);
            }
        } else {
            student.setUser(this);
        }
        this.student = student;
    }

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Notification> notifications = new ArrayList<>();

}
