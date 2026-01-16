package com.example.eventsphere.event;


import jdk.jfr.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/events")
public class EventPublicController {


    @Autowired
    private  EventService eventService;

    @GetMapping("/getinfo/{eventId}")
    public ResponseEntity<EventEntity> getEventInfo(@PathVariable  Long eventId){
        return ResponseEntity.ok(eventService.getEventInfo(eventId));
    }


    @GetMapping("/search")
    public List<EventEntity> searchEvents(@RequestParam String query){
        return eventService.searchEvents(query);
    }


    @GetMapping("/live")
    public List<EventEntity> getLiveEvents() {
        return eventService.getLiveEvents();
    }

    @GetMapping("/one")
    public EventEntity getEvent(@RequestParam Long eventId) {
        return eventService.getPublicEvent(eventId);
    }
}
