package org.learn.learningmanagementbackend.service.SchoolAdminService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.request.RoomRequest;
import org.learn.learningmanagementbackend.dto.response.RoomResponse;
import org.learn.learningmanagementbackend.model.Room;
import org.learn.learningmanagementbackend.model.SchoolBranch;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.RoomRepository;
import org.learn.learningmanagementbackend.repository.SchoolAdminRepository.SchoolBranchRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("schoolAdminRoomService")
@RequiredArgsConstructor
public class RoomService {

    private final RoomRepository roomRepository;
    private final SchoolBranchRepository branchRepository;

    public List<RoomResponse> getAllRoomsByBranch(Integer branchId) {
        return roomRepository.findBySchoolBranchId(branchId).stream().map(this::mapToResponse).collect(Collectors.toList());
    }

    public RoomResponse getRoomById(Integer id) {
        Room room = roomRepository.findById(id).orElseThrow(() -> new RuntimeException("Room not found"));
        return mapToResponse(room);
    }

    public RoomResponse createRoom(RoomRequest request) {
        SchoolBranch branch = branchRepository.findById(request.getSchoolBranchId())
                .orElseThrow(() -> new RuntimeException("Branch not found"));

        Room room = new Room();
        room.setSchoolBranch(branch);
        room.setRoomNumber(request.getRoomNumber());
        room.setBuilding(request.getBuilding());
        room.setRoomType(request.getRoomType());
        room.setCapacity(request.getCapacity());
        room.setEquipment(request.getEquipment());
        room.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        return mapToResponse(roomRepository.save(room));
    }

    public RoomResponse updateRoom(Integer id, RoomRequest request) {
        Room room = roomRepository.findById(id).orElseThrow(() -> new RuntimeException("Room not found"));

        if (!room.getSchoolBranch().getId().equals(request.getSchoolBranchId())) {
            SchoolBranch branch = branchRepository.findById(request.getSchoolBranchId())
                    .orElseThrow(() -> new RuntimeException("Branch not found"));
            room.setSchoolBranch(branch);
        }

        room.setRoomNumber(request.getRoomNumber());
        room.setBuilding(request.getBuilding());
        room.setRoomType(request.getRoomType());
        room.setCapacity(request.getCapacity());
        room.setEquipment(request.getEquipment());
        room.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);

        return mapToResponse(roomRepository.save(room));
    }

    public void deleteRoom(Integer id) {
        roomRepository.deleteById(id);
    }

    private RoomResponse mapToResponse(Room room) {
        RoomResponse response = new RoomResponse();
        response.setId(room.getId());
        response.setSchoolBranchId(room.getSchoolBranch() != null ? room.getSchoolBranch().getId() : null);
        response.setSchoolBranchName(room.getSchoolBranch() != null ? room.getSchoolBranch().getName() : null);
        response.setRoomNumber(room.getRoomNumber());
        response.setBuilding(room.getBuilding());
        response.setRoomType(room.getRoomType());
        response.setCapacity(room.getCapacity());
        response.setEquipment(room.getEquipment());
        response.setIsActive(room.getIsActive());
        return response;
    }
}
