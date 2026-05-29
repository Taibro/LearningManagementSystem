package org.learn.learningmanagementbackend.repository.SchoolAdminRepository;

import org.learn.learningmanagementbackend.model.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("schoolAdminRoomRepository")
public interface RoomRepository extends JpaRepository<Room, Integer> {
    List<Room> findBySchoolBranchId(Integer schoolBranchId);
}
