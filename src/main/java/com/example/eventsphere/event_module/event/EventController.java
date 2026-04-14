package com.example.eventsphere.event_module.event;


import com.example.eventsphere.event_module.dto.EventRequestDTO;
import com.example.eventsphere.event_module.dto.EventResponseDTO;
import com.example.eventsphere.user_module.UserEntity;
import com.example.eventsphere.user_module.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
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
    @PreAuthorize("hasRole('ORGANIZER')")
    public ResponseEntity<EventResponseDTO> createEvent(@AuthenticationPrincipal UserDetails userDetails, @RequestBody EventRequestDTO eventRequest){
        UserEntity user=userService.getProfileBio(userDetails);
            EventResponseDTO eventEntity = eventService.createEvent(eventRequest);
            return ResponseEntity.ok(eventEntity);
    }

    //get event by id
    @GetMapping("/{id}")
    public ResponseEntity<EventResponseDTO> getEventById(@AuthenticationPrincipal UserDetails userDetails,@PathVariable Long id){

        EventResponseDTO eventEntity=eventService.getEventById(id);
        return ResponseEntity.ok(eventEntity);
    }


    // get all the events
    @GetMapping
    public ResponseEntity<Page<EventResponseDTO>> getAllEvents(
            @AuthenticationPrincipal UserDetails user,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ){

        return ResponseEntity.ok(eventService.getAllEvents(page,size));
    }




    // update event
    @PreAuthorize("hasRole('ORGANIZER')")
    @PutMapping("{id}")
    public ResponseEntity<EventResponseDTO> updateEvent(@AuthenticationPrincipal UserDetails userDetails,@RequestBody EventRequestDTO eventRequestDTO,@PathVariable  Long id){

        EventResponseDTO eventResponseDTO = eventService.updateEvent(eventRequestDTO,id);
        return ResponseEntity.ok(eventResponseDTO);
    }




}
