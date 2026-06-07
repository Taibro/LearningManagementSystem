package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "user_chat_preferences")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserChatPreference extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_email", nullable = false)
    private String userEmail;

    @Column(name = "target_email", nullable = false)
    private String targetEmail;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    @Column(name = "is_pinned", columnDefinition = "boolean default false")
    private boolean isPinned = false;
}
