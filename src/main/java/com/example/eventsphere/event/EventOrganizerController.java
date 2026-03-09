package com.example.eventsphere.event;

import lombok.RequiredArgsConstructor;
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

    private final EventService eventService;


    // CREATE EVENT
    @PostMapping("/{clubId}")
    public EventEntity createEvent(
            @AuthenticationPrincipal UserDetails user,
            @RequestBody EventEntity event,
            @PathVariable Long clubId
    ){
        return eventService.createEvent(event, clubId);
    }


    // VIEW EVENTS OF CLUB
    @GetMapping("/club/{clubId}")
    public List<EventEntity> getClubEvents(

            @AuthenticationPrincipal UserDetails user,
            @PathVariable Long clubId
    ){
        return eventService.getClubEvents(clubId);
    }


    // UPDATE EVENT
    @PutMapping("/{eventId}")
    public EventEntity updateEvent(
            @AuthenticationPrincipal UserDetails user,
            @PathVariable Long eventId,
            @RequestBody EventEntity event
    ){
        return eventService.updateEvent(eventId, event);
    }


    // PUBLISH EVENT
    @PostMapping("/{eventId}/publish")
    public EventEntity publishEvent(
            @AuthenticationPrincipal UserDetails user,
            @PathVariable Long eventId
    ){
        return eventService.publishEvent(eventId);
    }


    // CANCEL EVENT
    @PutMapping("/{eventId}/cancel")
    public void cancelEvent(
            @AuthenticationPrincipal UserDetails user,
            @PathVariable Long eventId
    ){
        eventService.cancelEvent(eventId);
    }


    // DELETE EVENT
    @DeleteMapping("/{eventId}")
    public void deleteEvent(
            @AuthenticationPrincipal UserDetails user,
            @PathVariable Long eventId
    ){
        eventService.deleteEvent(eventId);
    }

}