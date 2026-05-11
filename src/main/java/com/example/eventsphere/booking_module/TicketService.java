package com.example.eventsphere.booking_module;


import com.example.eventsphere.event_module.event.EventEntity;
import com.example.eventsphere.event_module.event.EventRepo;
import com.example.eventsphere.exception_folder.InsufficientException;
import com.example.eventsphere.user_module.UserEntity;
import com.example.eventsphere.user_module.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class TicketService {

    private final EventRepo eventRepo;
    private final TicketRepo ticketRepo;
    private final UserRepo userRepo;


    public TicketEntity Booking(TicketRequestDTO ticketRequestDTO) {

        EventEntity event = eventRepo.findById(ticketRequestDTO.getEventId()).orElseThrow(() -> {
            return new NoSuchElementException("Event Not Found");
        });

        if (event.getCapacity() < ticketRequestDTO.getQuantity()) {
            throw new InsufficientException("No Enough Seats Left");
        }

        event.setCapacity(event.getCapacity() - ticketRequestDTO.getQuantity());
        EventEntity eventEntity=eventRepo.findById(ticketRequestDTO.getEventId()).orElseThrow(()->{
            return new NoSuchElementException("No Event Not Found With :"+ticketRequestDTO.getEventId()+"ID");
        });
        UserEntity userEntity= userRepo.findById(ticketRequestDTO.getUserId()).orElseThrow(()->{
            return new NoSuchElementException("No User Found With:"+ticketRequestDTO.getUserId()+"ID");
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
