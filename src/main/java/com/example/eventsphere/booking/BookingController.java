package com.example.eventsphere.booking;


import com.example.eventsphere.user.UserEntity;
import com.example.eventsphere.user.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/booking")
public class BookingController {
    @Autowired
    private BookingService bookingService;

    @Autowired
    private UserRepo userRepo;


    @PostMapping
    public ResponseEntity<?> confirmBooking(@AuthenticationPrincipal UserDetails user, @RequestBody BookingRequestDTO request)
    {
        final UserEntity currentuser;
        currentuser=userRepo.findByEmail(user.getUsername()).orElse(null);
        bookingService.BookingTicket(currentuser,request);
        return ResponseEntity.ok("Booking Confirmed");
    }






}
