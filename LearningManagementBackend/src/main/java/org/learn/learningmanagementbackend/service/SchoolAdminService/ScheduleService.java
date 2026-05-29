package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.ScheduleRequest;
import org.learn.learningmanagementbackend.dto.response.ScheduleResponse;
import org.learn.learningmanagementbackend.model.Classes;
import org.learn.learningmanagementbackend.model.Room;
import org.learn.learningmanagementbackend.model.Schedule;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.RoomRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.ScheduleRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminScheduleService")
@RequiredArgsConstructor
public class ScheduleService {

    private final ScheduleRepository scheduleRepository;
    private final RoomRepository roomRepository;
    // For Classes we just use dummy or entity manager reference
    // Since we don't have ClassesRepository in SchoolAdminRepository yet, we create it dynamically by just using setID

    public List<ScheduleResponse> getAllSchedulesByClass(Integer classId) {
        return scheduleRepository.findByClassesId(classId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public List<ScheduleResponse> getAllSchedulesByRoom(Integer roomId) {
        return scheduleRepository.findByRoomId(roomId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public ScheduleResponse getScheduleById(Integer id) {
        Schedule schedule = scheduleRepository.findById(id).orElseThrow(() -> new RuntimeException("Schedule not found"));
        return mapToResponse(schedule);
    }

    public ScheduleResponse createSchedule(ScheduleRequest request) {
        Room room = roomRepository.findById(request.getRoomId())
                .orElseThrow(() -> new RuntimeException("Room not found"));

        Classes classes = new Classes();
        classes.setId(request.getClassId());

        Schedule schedule = new Schedule();
        schedule.setClasses(classes);
        schedule.setRoom(room);
        schedule.setDayOfWeek(request.getDayOfWeek());
        schedule.setStartTime(request.getStartTime());
        schedule.setEndTime(request.getEndTime());
        schedule.setStartDate(request.getStartDate());
        schedule.setEndDate(request.getEndDate());
        schedule.setType(request.getType());
        schedule.setNotes(request.getNotes());
        schedule.setStartPeriod(request.getStartPeriod());
        schedule.setEndPeriod(request.getEndPeriod());

        return mapToResponse(scheduleRepository.save(schedule));
    }

    public ScheduleResponse updateSchedule(Integer id, ScheduleRequest request) {
        Schedule schedule = scheduleRepository.findById(id).orElseThrow(() -> new RuntimeException("Schedule not found"));

        if (!schedule.getRoom().getId().equals(request.getRoomId())) {
            Room room = roomRepository.findById(request.getRoomId())
                    .orElseThrow(() -> new RuntimeException("Room not found"));
            schedule.setRoom(room);
        }

        if (!schedule.getClasses().getId().equals(request.getClassId())) {
            Classes classes = new Classes();
            classes.setId(request.getClassId());
            schedule.setClasses(classes);
        }

        schedule.setDayOfWeek(request.getDayOfWeek());
        schedule.setStartTime(request.getStartTime());
        schedule.setEndTime(request.getEndTime());
        schedule.setStartDate(request.getStartDate());
        schedule.setEndDate(request.getEndDate());
        schedule.setType(request.getType());
        schedule.setNotes(request.getNotes());
        schedule.setStartPeriod(request.getStartPeriod());
        schedule.setEndPeriod(request.getEndPeriod());

        return mapToResponse(scheduleRepository.save(schedule));
    }

    public void deleteSchedule(Integer id) {
        scheduleRepository.deleteById(id);
    }

    private ScheduleResponse mapToResponse(Schedule schedule) {
        ScheduleResponse response = new ScheduleResponse();
        response.setId(schedule.getId());
        response.setClassId(schedule.getClasses() != null ? schedule.getClasses().getId() : null);
        response.setClassCode(schedule.getClasses() != null ? schedule.getClasses().getCode() : null);
        response.setRoomId(schedule.getRoom() != null ? schedule.getRoom().getId() : null);
        response.setRoomNumber(schedule.getRoom() != null ? schedule.getRoom().getRoomNumber() : null);
        response.setRoomBuilding(schedule.getRoom() != null ? schedule.getRoom().getBuilding() : null);
        response.setDayOfWeek(schedule.getDayOfWeek());
        response.setStartTime(schedule.getStartTime());
        response.setEndTime(schedule.getEndTime());
        response.setStartDate(schedule.getStartDate());
        response.setEndDate(schedule.getEndDate());
        response.setType(schedule.getType());
        response.setNotes(schedule.getNotes());
        response.setStartPeriod(schedule.getStartPeriod());
        response.setEndPeriod(schedule.getEndPeriod());
        return response;
    }
}
