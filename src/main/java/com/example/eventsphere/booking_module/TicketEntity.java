package com.example.eventsphere.booking_module;


import com.example.eventsphere.event_module.event.EventEntity;
import com.example.eventsphere.user_module.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name="ticket_table")
@Data
@Builder
public class TicketEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ticketid;
    @ManyToOne
    @JoinColumn(name = "event_id")
    private EventEntity event;
    @ManyToOne
    @JoinColumn(name="user_id")
    private UserEntity user;
    @Column(nullable = false)
    private Integer quantity;
    // for future reference
    //private Double price;
    @Column
    private LocalDateTime bookingTime= LocalDateTime.now();
}
