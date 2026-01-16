package com.example.eventsphere.event;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/attendee/events")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ATTENDEE')")
public class EventAttendeeController {

    private final EventService eventService;

    @PostMapping("/{eventId}/register")
    public ResponseEntity<?> register(@PathVariable Long eventId) {
        // logic
        return ResponseEntity.ok("Registered");
    }

}
