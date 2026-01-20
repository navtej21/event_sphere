package com.example.eventsphere.ticket;


import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
public class TicketResponseDTO {

    private String ticketCode;
    private String eventTitle;
    private LocalDate eventDate;
    private String eventTime;
    private String venue;

    private String attendeeName;
    private String attendeeEmail;

    private String bookedOn;
    private String status;
}
