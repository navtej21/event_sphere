package com.example.eventsphere.favorite;




import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FavoriteEventRepository
        extends JpaRepository<FavoriteEventEntity, Long> {

    // ❤️ Check if an event is favorited by a user (email)
    boolean existsByUser_EmailAndEvent_EventId(String email, Long eventId);

    // 💔 Remove favorite (unfavorite)
    void deleteByUser_EmailAndEvent_EventId(String email, Long eventId);

    // 📋 Get all favorite records of a user
    List<FavoriteEventEntity> findByUser_Email(String email);

    // 🔍 Get specific favorite row (optional)
    Optional<FavoriteEventEntity> findByUser_EmailAndEvent_EventId(
            String email,
            Long eventId
    );
}
