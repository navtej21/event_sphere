package com.example.eventsphere.ticket;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface TicketBookingRepo extends JpaRepository<TicketEntity,Long> {




}
