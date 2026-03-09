package com.example.eventsphere.review;

import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name="review")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reviewid;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private UserEntity user;

    @ManyToOne
    @JoinColumn(name = "eventid", nullable = false)
    private EventEntity event;

    @Min(1)
    @Max(5)
    private Integer rating;

    @Column(columnDefinition = "TEXT")
    private String comment;

    private LocalDateTime timestamp = LocalDateTime.now();
}
