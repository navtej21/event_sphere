package com.example.eventsphere.attendee;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AttendeeRepo extends JpaRepository<AttendeeEntity,Long> {

}
