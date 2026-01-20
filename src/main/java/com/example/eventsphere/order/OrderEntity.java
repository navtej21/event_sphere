package com.example.eventsphere.order;


import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name="booking")
@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class OrderEntity {


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer orderid;

    @ManyToOne
    @JoinColumn(name="user_id",nullable = false)
    private UserEntity user;

    @ManyToOne
    @JoinColumn(name="event_id",nullable = false)
    private EventEntity event;

    @Column(nullable = false,precision = 10,scale = 2)
    private BigDecimal totalamount=BigDecimal.ZERO;

    @Column(nullable = false)
    private Integer totalTickets;

    @Column
    private LocalDate createdAT=LocalDate.now();








}
