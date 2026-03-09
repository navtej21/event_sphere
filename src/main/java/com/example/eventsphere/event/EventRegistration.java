package com.example.eventsphere.event;


import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import org.hibernate.annotations.CurrentTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name="registrations")
public class EventRegistration {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;


    @ManyToOne
    private EventEntity event;

    @ManyToOne
    private UserEntity user;

    private LocalDateTime registeredAt;

    private boolean checkedIn;
}
