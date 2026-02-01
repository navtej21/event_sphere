package com.example.eventsphere.event;

import com.example.eventsphere.user.UserEntity;
import com.example.eventsphere.user.UserRepo;
import jdk.jfr.Event;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/organizer/events")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ORGANIZER')")
public class EventOrganizerController {


    @Autowired
    private  EventService eventService;

    @Autowired
    private final UserRepo userRepo;

    private UserEntity getOrganizer(UserDetails user) {
        return userRepo.findByEmail(user.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
    }

    @PostMapping
    public EventEntity createEvent(
            @RequestBody EventEntity event,
            @AuthenticationPrincipal UserDetails user
    ) {
        return eventService.createEvent(event, getOrganizer(user));
    }


    @GetMapping("/draft")
    public ResponseEntity<List<EventEntity>> getDraftEvents(@AuthenticationPrincipal UserDetails user)
    {
        return ResponseEntity.ok(eventService.getDraftEvents());
    }

    @PutMapping("/{eventId}")
    public EventEntity updateEvent(
            @PathVariable Long eventId,
            @RequestBody EventEntity event,
            @AuthenticationPrincipal UserDetails user
    ) {
        return eventService.updateEvent(
                eventId,
                event,
                getOrganizer(user).getUserId()
        );
    }

    @PostMapping("/{eventId}/publish")
    public EventEntity publishEvent(
            @PathVariable Long eventId,
            @AuthenticationPrincipal UserDetails user
    ) {
        return eventService.publishEvent(eventId, getOrganizer(user).getUserId());
    }

    @PutMapping("/{eventId}/cancel")
    public ResponseEntity<?> cancelEvent(
            @PathVariable Long eventId,
            @AuthenticationPrincipal UserDetails user
    ) {
        eventService.cancelEvent(eventId, getOrganizer(user).getUserId());
        return ResponseEntity.ok("Event cancelled");
    }

    @DeleteMapping("/{eventId}")
    public ResponseEntity<?> deleteEvent(
            @PathVariable Long eventId,
            @AuthenticationPrincipal UserDetails user
    ) {
        eventService.deleteEvent(eventId, getOrganizer(user).getUserId());
        return ResponseEntity.ok("Event deleted");
    }


    @GetMapping
    public List<EventEntity> getOrganizerEvents(
            @AuthenticationPrincipal UserDetails user
    ) {
        return eventService.getOrganizerEvents(getOrganizer(user).getUserId());
    }
}
