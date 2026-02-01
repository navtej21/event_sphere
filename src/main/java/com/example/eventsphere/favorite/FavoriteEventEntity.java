package com.example.eventsphere.favorite;


import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table
@Setter
@Getter
@Data
public class FavoriteEventEntity{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long favorite_id;


    @ManyToOne
    @JoinColumn(nullable = false,name = "user_id")
    private UserEntity user;


    @ManyToOne
    @JoinColumn(nullable = false,name="event_id")
    private EventEntity event;


    @Column
    private LocalDateTime DateTime=LocalDateTime.now();
}