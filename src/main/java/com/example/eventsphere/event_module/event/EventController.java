package com.example.eventsphere.event_module.event;


import com.example.eventsphere.event_module.dto.EventRequestDTO;
import com.example.eventsphere.event_module.dto.EventResponseDTO;
import com.example.eventsphere.user_module.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.awt.print.Pageable;
import java.util.List;

@RestController
@RequestMapping("/api/v1/events")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;
    private final UserService userService;


    // create event by (admin)
    @PostMapping
    public ResponseEntity<EventResponseDTO> createEvent(@RequestBody EventRequestDTO eventRequest){

        EventResponseDTO eventEntity=eventService.createEvent(eventRequest);
        return ResponseEntity.ok(eventEntity);
    }

    //get event by id
    @GetMapping("/{id}")
    public ResponseEntity<EventResponseDTO> getEventById(@PathVariable Long id){

        EventResponseDTO eventEntity=eventService.getEventById(id);
        return ResponseEntity.ok(eventEntity);
    }


    // get all the events
    @GetMapping
    public ResponseEntity<Page<EventResponseDTO>> getAllEvents(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ){

        return ResponseEntity.ok(eventService.getAllEvents(page,size));
    }




    // update event
    @PutMapping("{id}")
    public ResponseEntity<EventResponseDTO> updateEvent(@RequestBody EventRequestDTO eventRequestDTO,@PathVariable  Long id){

        EventResponseDTO eventResponseDTO = eventService.updateEvent(eventRequestDTO,id);
        return ResponseEntity.ok(eventResponseDTO);
    }




}
