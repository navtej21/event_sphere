package com.example.eventsphere.favorite;

import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(
        name = "favorite_events",
        uniqueConstraints = @UniqueConstraint(columnNames = {"email", "event_id"})
)
@Data
@NoArgsConstructor
public class FavoriteEventEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long favoriteeventid;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "email", nullable = false)
    private UserEntity user;


    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "event_id", nullable = false)
    private EventEntity event;
}
