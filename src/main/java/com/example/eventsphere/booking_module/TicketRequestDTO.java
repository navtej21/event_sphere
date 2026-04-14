package com.example.eventsphere.booking_module;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TicketRequestDTO {
    private Long userId;
    private Long eventId;
    private Integer quantity;
}
