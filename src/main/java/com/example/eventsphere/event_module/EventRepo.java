package com.example.eventsphere.event_module;

import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepo extends JpaRepository<EventEntity,Long> {


}
