package com.example.eventsphere.payment;

import com.example.eventsphere.enums.PaymentMethod;
import com.example.eventsphere.enums.PaymentStatus;
import com.example.eventsphere.ticket.TicketEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payment")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long paymentid;

    @OneToOne
    @JoinColumn(name = "ticketid", nullable = false, unique = true)
    private TicketEntity ticket;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal amount;

    @Enumerated(EnumType.STRING)
    private PaymentMethod paymentmethod;

    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentstatus = PaymentStatus.PENDING;

    private LocalDateTime transactiondate = LocalDateTime.now();

    private String gatewayreference;
}
