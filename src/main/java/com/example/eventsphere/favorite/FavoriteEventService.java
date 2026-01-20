package com.example.eventsphere.favorite;

import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.event.EventRepository;
import com.example.eventsphere.user.UserEntity;
import com.example.eventsphere.user.UserRepo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class FavoriteEventService {

    private final FavoriteEventRepository favoriteRepo;
    private final UserRepo userRepo;
    private final EventRepository eventRepo;

    public FavoriteEventService(
            FavoriteEventRepository favoriteRepo,
            UserRepo userRepo,
            EventRepository eventRepo
    ) {
        this.favoriteRepo = favoriteRepo;
        this.userRepo = userRepo;
        this.eventRepo = eventRepo;
    }


    @Transactional
    public boolean toggleFavorite(String email, Long eventId) {

        boolean exists =
                favoriteRepo.existsByUser_EmailAndEvent_EventId(email, eventId);

        if (exists) {
            favoriteRepo.deleteByUser_EmailAndEvent_EventId(email, eventId);
            return false; // unfavorited
        }

        UserEntity user =
                userRepo.findByEmail(email)
                        .orElseThrow(() -> new RuntimeException("User not found"));

        EventEntity event =
                eventRepo.findById(eventId)
                        .orElseThrow(() -> new RuntimeException("Event not found"));

        FavoriteEventEntity favorite = new FavoriteEventEntity();
        favorite.setUser(user);
        favorite.setEvent(event);

        favoriteRepo.save(favorite);
        return true;
    }

    public boolean isFavorite(String email, Long eventId) {
        return favoriteRepo
                .existsByUser_EmailAndEvent_EventId(email, eventId);
    }


    public List<EventEntity> getFavoriteEvents(String email) {

        return favoriteRepo.findByUser_Email(email)
                .stream()
                .map(FavoriteEventEntity::getEvent)
                .collect(Collectors.toList());
    }
}
