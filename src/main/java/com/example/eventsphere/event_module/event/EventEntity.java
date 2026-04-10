package com.example.eventsphere.event_module.event;

import com.example.eventsphere.enums.EventStatus;
import com.example.eventsphere.event_module.category.CategoryEntity;
import com.example.eventsphere.user_module.UserEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

@Entity
@Table(
        name = "event",
        indexes = {
                @Index(name = "idx_event_category", columnList = "categoryid"),
                @Index(name = "idx_event_organizer", columnList = "organizerid")
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long eventid;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private LocalDate date;

    @Column(nullable = false)
    private LocalTime time;

    @Column(nullable = false, length = 200)
    private String venue;

    @Column(nullable = false)
    private Integer capacity;


    // Many events → one category
    @ManyToOne
    @JoinColumn(name = "categoryid")
    private CategoryEntity category;

    // Many events → one user (organizer)
    @ManyToOne
    @JoinColumn(name = "organizerid")
    private UserEntity organizer;

    @Enumerated(EnumType.STRING)
    private EventStatus status = EventStatus.ACTIVE;

    private LocalDateTime createdat = LocalDateTime.now();
}