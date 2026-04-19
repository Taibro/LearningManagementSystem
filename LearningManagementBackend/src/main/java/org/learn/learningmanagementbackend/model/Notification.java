package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.learn.learningmanagementbackend.enums.NotificationType;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "Notification")
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private Users user;

    @Column(name = "title", length = 200, nullable = false)
    private String title;

    @Column(name = "body", nullable = false)
    private String body;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private NotificationType type;

    @Column(name = "is_read", nullable = false)
    private Boolean isRead;

    @Column(name = "ref_type")
    private String refType;

    @Column(name = "ref_id")
    private String refId;

    @Column(name = "created_at", updatable = false)
    @CreationTimestamp
    private LocalDateTime createdAt;

    @Column(name = "read_at")
    private LocalDateTime readAt;
}
