package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import org.learn.learningmanagementbackend.enums.RoomType;

import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "Room")
public class Room extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id", referencedColumnName = "id")
    private SchoolBranch schoolBranch;

    @Column(name = "building", length = 50)
    private String building;

    @Column(name = "room_number", length = 20)
    private String roomNumber;

    @Column(name = "capacity")
    private Integer capacity;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private RoomType roomType;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "equipment", columnDefinition = "json")
    private List<String> equipment;

    @Column(name = "is_active")
    private Boolean isActive;
}
