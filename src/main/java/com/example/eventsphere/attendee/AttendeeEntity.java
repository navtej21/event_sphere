package com.example.eventsphere.attendee;


import com.example.eventsphere.ticket.TicketEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Generated;
import lombok.NoArgsConstructor;

@Entity
@Table(name="attendee")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class AttendeeEntity {


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long attendeeId;


    @OneToOne
    private TicketEntity ticket;

    @Column(unique = true)
    @Email
    private String email;

    @Column
    private String name;
}
