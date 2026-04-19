package org.learn.learningmanagementbackend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.ScheduleType;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "Schedule")
public class Schedule extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "class_id", referencedColumnName = "id", nullable = false)
    private Classes classes;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "room_id", referencedColumnName = "id", nullable = false)
    private Room room;

    @Column(name = "day_of_week", nullable = false)
    private Integer dayOfWeek;

    @Column(name = "start_time", nullable = false)
    private LocalTime startTime;

    @Column(name = "end_time", nullable = false)
    private LocalTime endTime;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false)
    private ScheduleType type;

    @Column(name = "notes")
    private String notes;

    @OneToMany(mappedBy = "schedule", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ScheduleException> scheduleException = new ArrayList<>();

    public void addException(ScheduleException exception){
        this.scheduleException.add(exception);
        exception.setSchedule(this);
    }

    @OneToMany(mappedBy = "schedule", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<AttendanceRecord> attendanceRecords = new ArrayList<>();

    public void addAttendanceRecord(AttendanceRecord attendanceRecord){
        this.attendanceRecords.add(attendanceRecord);
        attendanceRecord.setSchedule(this);
    }
}
