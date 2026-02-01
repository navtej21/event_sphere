package com.example.eventsphere.favorite;




import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FavoriteEventRepository
        extends JpaRepository<FavoriteEventEntity, Long> {

    boolean existsByUser_EmailAndEvent_EventId(String email, Long eventId);


    void deleteByUser_EmailAndEvent_EventId(String email, Long eventId);


    List<FavoriteEventEntity> findByUser_Email(String email);


    Optional<FavoriteEventEntity> findByUser_EmailAndEvent_EventId(
            String email,
            Long eventId
    );
}
