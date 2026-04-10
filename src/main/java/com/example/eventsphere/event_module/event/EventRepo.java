package com.example.eventsphere.event_module.event;

import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepo extends JpaRepository<EventEntity,Long> {


}
