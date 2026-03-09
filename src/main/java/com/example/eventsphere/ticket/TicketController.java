//package com.example.eventsphere.ticket;
//
//
//import com.example.eventsphere.event.EventRepository;
//import com.example.eventsphere.order.OrderRepo;
//import com.example.eventsphere.user.UserEntity;
//import com.example.eventsphere.user.UserRepo;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.security.core.annotation.AuthenticationPrincipal;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//import java.util.List;
//@RestController
//@PreAuthorize("hasRole('ATTENDEE')")
//@RequestMapping("/tickets")
//public class TicketController {
//
//    @Autowired
//    private UserRepo userRepo;
//
//    @Autowired
//    private EventRepository eventRepo;
//
//    @Autowired
//    private TicketBookingRepo ticketRepo;
//
//    @Autowired
//    private OrderRepo orderRepo;
//
//
////    public ResponseEntity<List<TicketEntity>> getMyTickets(@AuthenticationPrincipal UserDetails user){
////
////        final Long userId=userRepo.findByEmail(user.getUsername()).get().getUserId();
////        List<TicketEntity> lstofallticketsbooked=ticketRepo.find
////
////    }
//
//
//
//
//
//
//
//
//}
