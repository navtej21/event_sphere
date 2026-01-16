package com.example.eventsphere.notification;

import com.example.eventsphere.enums.DeliveryMode;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "notification")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class NotificationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long notificationid;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private UserEntity user;

    private String type;

    @Column(columnDefinition = "TEXT")
    private String message;

    @Enumerated(EnumType.STRING)
    private DeliveryMode deliverymode;

    private LocalDateTime senttimestamp = LocalDateTime.now();
}
