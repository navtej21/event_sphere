package com.example.eventsphere.event;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/events")
@RequiredArgsConstructor
public class EventAttendeeController {

    private final EventService eventService;


    // VIEW ALL PUBLIC EVENTS
    @GetMapping("/live")
    public List<EventEntity> getLiveEvents(@AuthenticationPrincipal UserDetails user) {
        return eventService.getLiveEvents();
    }


    @GetMapping("/getinfo/{eventId}")
    public ResponseEntity<EventEntity> getEventInfo(@AuthenticationPrincipal UserDetails user,@PathVariable  Long eventId){
        return ResponseEntity.ok(eventService.getEventInfo(eventId));
    }



    @GetMapping("/search")
    public List<EventEntity> searchEvents(@AuthenticationPrincipal UserDetails user,@RequestParam String query){
        return eventService.searchEvents(query);
    }

}