package com.example.eventsphere.order;


import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.event.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService {

    @Autowired
    private OrderRepo orderRepo;

    @Autowired
    private EventRepository eventRepo;

    public boolean AvialablityCheck(Long eventid,Long quantity){
        EventEntity event=eventRepo.findByEventId(eventid);
        return event.getAvailable()>=quantity;
    }
}
