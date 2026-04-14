package com.example.eventsphere.booking_module;


import com.example.eventsphere.event_module.event.EventEntity;
import com.example.eventsphere.event_module.event.EventRepo;
import com.example.eventsphere.user_module.UserEntity;
import com.example.eventsphere.user_module.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TicketService {

    private final EventRepo eventRepo;
    private final TicketRepo ticketRepo;
    private final UserRepo userRepo;


    public TicketEntity Booking(TicketRequestDTO ticketRequestDTO) {

        EventEntity event = eventRepo.findById(ticketRequestDTO.getEventId()).orElseThrow(() -> {
            return new RuntimeException("No Event Found");
        });

        if (event.getCapacity() < ticketRequestDTO.getQuantity()) {
            throw new IllegalArgumentException("No Enough Seats Left");
        }

        event.setCapacity(event.getCapacity() - ticketRequestDTO.getQuantity());
        EventEntity eventEntity=eventRepo.findById(ticketRequestDTO.getEventId()).orElseThrow(()->{
            return new RuntimeException("No Event Not Found");
        });
        UserEntity userEntity= userRepo.findById(ticketRequestDTO.getUserId()).orElseThrow(()->{
            return new RuntimeException("No User Found");
        });

        TicketEntity ticketEntity = TicketEntity.builder().event(eventEntity).user(userEntity).build();
        eventRepo.save(event);
        TicketEntity ticketEntity1 = ticketRepo.save(ticketEntity);

        return ticketEntity1;
    }


    public TicketResponseDTO mapToResponse(TicketEntity ticketEntity){

        return TicketResponseDTO.builder().ticketId(ticketEntity.getTicketid()).quantity(ticketEntity.getQuantity()).build();
    }


}
