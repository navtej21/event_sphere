package com.example.eventsphere.ticket;


import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.order.OrderEntity;
import com.example.eventsphere.enums.TicketStatus;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "ticket")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TicketEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ticketId;

    @ManyToOne
    @JoinColumn(name = "order_id",nullable = false)
    private OrderEntity order;

    @ManyToOne
    @JoinColumn(name="event_id",nullable = false)
    private EventEntity event;


    @Column(name="price")
    private BigDecimal price=BigDecimal.ZERO;

    @Enumerated(EnumType.STRING)
    private TicketStatus ticketStatus=TicketStatus.BOOKED;

    @Column
    private LocalDateTime createdAt=LocalDateTime.now();

}
