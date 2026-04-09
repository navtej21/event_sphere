package com.example.eventsphere.event_module;


import com.example.eventsphere.user_module.UserEntity;
import com.example.eventsphere.user_module.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

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
                .orElseThrow(() -> new RuntimeException("Category not found"));


        UserEntity user = userRepo.findById(dto.getOrganizerId())
                .orElseThrow(() -> new RuntimeException("User not found"));


        EventEntity event = EventEntity.builder()
                .title(dto.getTitle())
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



    public List<EventResponseDTO> getAllEvents() {
        return eventRepo.findAll()
                .stream()
                .map(this::mapToResponse)
                .toList();
    }



    public EventResponseDTO getEventById(Long id) {
        EventEntity event = eventRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Event not found"));

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
