package com.example.eventsphere.booking_module;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TicketResponseDTO {
    private Long ticketId;
    private String ticketTitle;
    private Integer quantity;
}
