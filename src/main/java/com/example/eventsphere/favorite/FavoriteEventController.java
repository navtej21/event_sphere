package com.example.eventsphere.favorite;
import org.springframework.web.bind.annotation.RequestMapping;
import com.example.eventsphere.event.EventEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//@RestController
//@RequestMapping("/api/favorites")
//public class FavoriteEventController {
//
//    private final FavoriteEventService favoriteService;
//
//    public FavoriteEventController(FavoriteEventService favoriteService) {
//        this.favoriteService = favoriteService;
//    }
//
//
//    @PostMapping("/toggle")
//    public ResponseEntity<Boolean> toggleFavorite(
//            @RequestParam Long eventId,
//            @AuthenticationPrincipal UserDetails user
//    ) {
//        boolean isFavorite =
//                favoriteService.toggleFavorite(user.getUsername(), eventId);
//
//        return ResponseEntity.ok(isFavorite);
//    }
//
//
//    @GetMapping("/status")
//    public ResponseEntity<Boolean> isFavorite(
//            @RequestParam Long eventId,
//            @AuthenticationPrincipal UserDetails user
//    ) {
//        boolean isFavorite =
//                favoriteService.isFavorite(user.getUsername(), eventId);
//
//        return ResponseEntity.ok(isFavorite);
//    }
//
//
//    @GetMapping
//    public ResponseEntity<List<EventEntity>> getFavorites(
//            @AuthenticationPrincipal UserDetails user
//    ) {
//        return ResponseEntity.ok(
//                favoriteService.getFavoriteEvents(user.getUsername())
//        );
//    }
//}
