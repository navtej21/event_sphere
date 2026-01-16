package com.example.eventsphere.booking;


import com.example.eventsphere.attendee.AttendeeDTO;
import com.example.eventsphere.attendee.AttendeeEntity;
import com.example.eventsphere.attendee.AttendeeRepo;
import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.event.EventRepository;
import com.example.eventsphere.event.EventService;
import com.example.eventsphere.order.OrderEntity;
import com.example.eventsphere.order.OrderRepo;
import com.example.eventsphere.ticket.TicketBookingRepo;
import com.example.eventsphere.ticket.TicketEntity;
import com.example.eventsphere.user.UserEntity;
import jakarta.transaction.Transactional;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
public class BookingService {

    @Autowired
    private AttendeeRepo attendeeRepo;

    @Autowired
    private TicketBookingRepo ticketRepo;

    @Autowired
    private EventService eventService;

    @Autowired
    private EventRepository eventRepo;

    @Autowired
    private OrderRepo orderRepo;


    @Transactional
    public void BookingTicket(UserEntity user,BookingRequestDTO bookingRequest)
    {

        Long eventid=bookingRequest.getEventId();
        int ticketcount=bookingRequest.getAttendees().size();

        boolean updated=eventService.reduceAvailableSeats(bookingRequest.getEventId(),ticketcount);


        if(updated==false){
            throw new IllegalArgumentException("no avaiable seats");
        }

        EventEntity event=eventRepo.findByEventId(eventid);
        OrderEntity order=new OrderEntity();

        order.setUser(user);
        order.setCreatedAT(LocalDate.now());
        order.setEvent(event);
        order.setTotalTickets(ticketcount);
        order.setTotalamount(BigDecimal.ZERO);
        orderRepo.save(order);


        for(AttendeeDTO attendee: bookingRequest.getAttendees()){
            TicketEntity ticket=new TicketEntity();
            ticket.setOrder(order);
            ticket.setEvent(event);

            ticketRepo.save(ticket);

            AttendeeEntity attendees=new AttendeeEntity();
            attendees.setTicket(ticket);
            attendees.setName(attendee.getName());
            attendees.setEmail(attendee.getEmail());
            attendeeRepo.save(attendees);
        }



    }




}
