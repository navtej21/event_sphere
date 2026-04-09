package com.example.eventsphere.event_module;

import com.example.eventsphere.enums.EventStatus;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventResponseDTO {

    private Long eventId;

    private String title;
    private String description;

    private LocalDate date;
    private LocalTime time;

    private String venue;
    private Integer capacity;

    private String categoryName;   // better than full object
    private String organizerName;

    private EventStatus status;
    private LocalDateTime createdAt;
}