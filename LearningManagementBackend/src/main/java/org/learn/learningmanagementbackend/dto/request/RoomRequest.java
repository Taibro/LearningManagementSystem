package org.learn.learningmanagementbackend.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.learn.learningmanagementbackend.enums.RoomType;

import java.util.List;

@Getter
@Setter
public class RoomRequest {

    @NotNull(message = "School Branch ID is required")
    private Integer schoolBranchId;

    @NotBlank(message = "Room number is required")
    private String roomNumber;

    private String building;

    @NotNull(message = "Room type is required")
    private RoomType roomType;

    @NotNull(message = "Capacity is required")
    private Integer capacity;

    private List<String> equipment;

    private Boolean isActive;
}
