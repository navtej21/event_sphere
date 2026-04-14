package com.example.eventsphere.booking_module;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/tickets")
public class TicketController {

    private final TicketService ticketService;
    @PostMapping
    public ResponseEntity<TicketResponseDTO> bookTicket(@AuthenticationPrincipal UserDetails userDetails, @RequestBody TicketRequestDTO ticketRequestDTO){
 return ResponseEntity.ok(ticketService.mapToResponse(ticketService.Booking(ticketRequestDTO)));
    }
}
