package com.example.eventsphere.event;


import com.example.eventsphere.club.ClubEntity;
import com.example.eventsphere.enums.EventFeeType;
import com.example.eventsphere.enums.EventLocation;
import com.example.eventsphere.enums.EventStatus;
import com.example.eventsphere.enums.EventVisiblity;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;


@Entity
@Table(name = "event")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EventEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long eventId;

    @Column
    private String title;

    @Column(columnDefinition = "TEXT",length = 140)
    private String description;

    @Column()
    private LocalDate startDate;

    @Column()
    private LocalTime startTime;

    @Column()
    private LocalDate endDate;

    @Column()
    private LocalTime endTime;

    @Column()
    private String venue;

    @Column()
    private Integer capacity;



    @Column(nullable = false)
    private Integer available;
    @Column
    private String imageurl;

    @Column
    @Enumerated(EnumType.STRING)
    private EventFeeType FeeType=EventFeeType.FREE;


    @Column
    private Double Fee=0d;


    @ManyToOne
    @JoinColumn(name="club_id")
    private ClubEntity club;

    @Column
    @Enumerated(EnumType.STRING)
    private EventStatus status=EventStatus.INACTIVE;

    @Column
    @Enumerated(EnumType.STRING)
    private EventLocation location=EventLocation.OFFLINE;

    @Column
    @Enumerated(EnumType.STRING)
    private EventVisiblity visibility = EventVisiblity.PRIVATE;

    @Column(updatable = false)
    private LocalDateTime createdAt ;

    @Column(updatable = true)
    private LocalDateTime updatedAt;


    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity organizer;

    @PrePersist
    public void prepersist()
    {
        if(available==null)
        {
            available=capacity;
        }
        createdAt=LocalDateTime.now();
        updatedAt=LocalDateTime.now();
    }

}
