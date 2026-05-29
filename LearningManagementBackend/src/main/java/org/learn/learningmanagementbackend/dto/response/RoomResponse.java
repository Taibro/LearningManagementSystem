package org.learn.learningmanagementbackend.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.RoomType;

import java.util.List;

@Getter
@Setter
public class RoomResponse {
    private Integer id;
    private Integer schoolBranchId;
    private String schoolBranchName;
    private String roomNumber;
    private String building;
    private RoomType roomType;
    private Integer capacity;
    private List<String> equipment;
    private Boolean isActive;
}
