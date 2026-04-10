package com.example.eventsphere.event_module.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventRequestDTO {

    private String title;
    private String description;

    private LocalDate date;
    private LocalTime time;

    private String venue;
    private Integer capacity;

    private Long categoryId;   // instead of CategoryEntity
    private Long organizerId;  // instead of UserEntity
}