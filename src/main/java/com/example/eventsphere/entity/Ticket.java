package com.example.eventsphere.entity;
//
//import com.example.eventsphere.enums.TicketStatus;
//import jakarta.persistence.*;
//import lombok.AllArgsConstructor;
//import lombok.Builder;
//import lombok.Data;
//import lombok.NoArgsConstructor;
//import org.hibernate.annotations.CreationTimestamp;
//import org.hibernate.annotations.UpdateTimestamp;
//
//import java.time.LocalDateTime;
//import java.util.UUID;
//
//@Data
//@Builder
//@NoArgsConstructor
//@AllArgsConstructor
//@Entity
//@Table(name = "ticket")
//public class Ticket {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "ticket_id")
//    private Long id;
//
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "booking_id", nullable = false)
//    private  booking;
//
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "tier_id", nullable = false)
//    private EventTicketTier ticketTier;
//
//    @Column(name = "unique_code", nullable = false, unique = true, updatable = false)
//    @Builder.Default
//    private String uniqueCode = UUID.randomUUID().toString();
//
//    @Enumerated(EnumType.STRING)
//    @Column(name = "ticket_status", length = 20)
//    @Builder.Default
//    private TicketStatus ticketStatus = TicketStatus.ISSUED;
//
//    @CreationTimestamp
//    @Column(name = "created_at", updatable = false)
//    private LocalDateTime createdAt;
//
//    @UpdateTimestamp
//    @Column(name = "updated_at")
//    private LocalDateTime updatedAt;
//}
