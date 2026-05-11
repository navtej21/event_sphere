package com.example.eventsphere.event_module.event;


import com.example.eventsphere.event_module.category.CategoryEntity;
import com.example.eventsphere.event_module.category.CategoryRepo;
import com.example.eventsphere.event_module.dto.EventRequestDTO;
import com.example.eventsphere.event_module.dto.EventResponseDTO;
import com.example.eventsphere.user_module.UserEntity;
import com.example.eventsphere.user_module.UserRepo;
import jdk.jfr.Event;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class EventService{

    private final EventRepo eventRepo;
    private final CategoryRepo categoryRepo;
    private final UserRepo userRepo;

    public EventResponseDTO createEvent(EventRequestDTO dto) {


        if (dto.getCapacity() <= 0) {
            throw new RuntimeException("Capacity must be greater than 0");
        }


        CategoryEntity category = categoryRepo.findById(dto.getCategoryId())
                .orElseThrow(() -> new NoSuchElementException("No Category Found"));


        UserEntity user = userRepo.findById(dto.getOrganizerId())
                .orElseThrow(() -> new NoSuchElementException("No User Found"));


        EventEntity event = EventEntity.builder()
                .title(dto.getTitle())
                .createdat(LocalDateTime.now())
                .description(dto.getDescription())
                .date(dto.getDate())
                .time(dto.getTime())
                .venue(dto.getVenue())
                .capacity(dto.getCapacity())
                .category(category)
                .organizer(user)
                .build();

        EventEntity saved = eventRepo.save(event);

        return mapToResponse(saved);
    }



    public EventResponseDTO updateEvent(EventRequestDTO event,Long id){

        EventEntity eventEntity=eventRepo.findById(id).orElseThrow(()->{
          return   new NoSuchElementException("Event Not Found");
        });

        CategoryEntity categoryEntity=categoryRepo.findById(event.getCategoryId()).orElseThrow(()->{
            return new NoSuchElementException("Category Not Found");
        });

        UserEntity userEntity=userRepo.findById(event.getOrganizerId()).orElseThrow(()->{
            return new NoSuchElementException("User Not Found");
        });

        eventEntity.setCapacity(event.getCapacity());
        eventEntity.setTitle(event.getTitle());
        eventEntity.setDescription(event.getDescription());
        eventEntity.setDate(event.getDate());
        eventEntity.setCapacity(event.getCapacity());
        eventEntity.setCategory(categoryEntity);
        eventEntity.setOrganizer(userEntity);

        return mapToResponse(eventRepo.save(eventEntity));

    }



    public void deleteEvent(Long eventId){
        EventEntity eventEntity=eventRepo.findById(eventId).orElseThrow(()->{
            return new NoSuchElementException("Event Not Found Exception");
        });
        eventRepo.deleteById(eventId);
    }



    public Page<EventResponseDTO> getAllEvents(int page, int size) {

        Pageable pageable=PageRequest.of(page,size);
        Page<EventEntity> events=eventRepo.findAll(pageable);

        return events.map((event)->{
            return mapToResponse(event);
        });
    }



    public EventResponseDTO getEventById(Long id) {
        EventEntity event = eventRepo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Event not found"));

        return mapToResponse(event);
    }


    private EventResponseDTO mapToResponse(EventEntity event) {

        return EventResponseDTO.builder()
                .eventId(event.getEventid())
                .title(event.getTitle())
                .description(event.getDescription())
                .date(event.getDate())
                .time(event.getTime())
                .venue(event.getVenue())
                .capacity(event.getCapacity())
                .categoryName(
                        event.getCategory() != null
                                ? event.getCategory().getCategoryName()
                                : null
                )
                .organizerName(
                        event.getOrganizer() != null
                                ? event.getOrganizer().getName()
                                : null
                )
                .status(event.getStatus())
                .createdAt(event.getCreatedat())
                .build();
    }





}
