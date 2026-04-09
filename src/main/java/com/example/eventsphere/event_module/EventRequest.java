package com.example.eventsphere.event_module;

import com.example.eventsphere.enums.EventStatus;
import com.example.eventsphere.user_module.UserEntity;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
@Builder
public class EventRequest {


    private String title;
    private String description;
    private LocalDate date;
    private LocalTime time;
    private String venue;
    private Integer capacity;
    private CategoryEntity category;
    private UserEntity organizer;
    @Enumerated(EnumType.STRING)
    private EventStatus status = EventStatus.ACTIVE;
    private LocalDateTime createdat = LocalDateTime.now();
}
