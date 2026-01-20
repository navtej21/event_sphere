package com.example.eventsphere.event;

import com.example.eventsphere.attendee.AttendeeEntity;
import com.example.eventsphere.category.CategoryEntity;
import com.example.eventsphere.enums.EventFeeType;
import com.example.eventsphere.enums.EventLocation;
import com.example.eventsphere.enums.EventStatus;
import com.example.eventsphere.enums.EventVisiblity;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "event")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EventEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long eventId;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT",length = 140)
    private String description;

    @Column(nullable = false)
    private LocalDate startDate;

    @Column(nullable = false)
    private LocalTime startTime;

    @Column(nullable = false)
    private LocalDate endDate;

    @Column(nullable = false)
    private LocalTime endTime;

    @Column(nullable = false)
    private String venue;

    @Column(nullable = false)
    private Integer capacity;

    @Column(nullable = false)
    private Integer available=capacity;

    @Column
    private String imageurl;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private EventFeeType FeeType=EventFeeType.FREE;


    @Column(nullable = false)
    private Double Fee=0d;


    @ManyToOne
    @JoinColumn(name = "categoryid")
    private CategoryEntity category;

    @ManyToOne
    @JoinColumn(name = "organizerid", nullable = false)
    private UserEntity organizer;

    @Column
    @Enumerated(EnumType.STRING)
    private EventStatus status=EventStatus.DRAFT;

    @Column
    @Enumerated(EnumType.STRING)
    private EventLocation location=EventLocation.OFFLINE;

    @Column
    @Enumerated(EnumType.STRING)
    private EventVisiblity visibility = EventVisiblity.PRIVATE;



    @Column(updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(updatable = true)
    private LocalDateTime updatedAt=LocalDateTime.now();




}
