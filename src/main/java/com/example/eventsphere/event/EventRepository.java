package com.example.eventsphere.event;

import com.example.eventsphere.enums.EventStatus;
import com.example.eventsphere.enums.EventVisiblity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface EventRepository extends JpaRepository<EventEntity, Long> {


    List<EventEntity> findByStatusAndVisibility(
            EventStatus status,
            EventVisiblity visibility
    );

    Optional<EventEntity> findByEventIdAndStatusAndVisibility(
            Long eventId,
            EventStatus status,
            EventVisiblity eventVisiblity
    );

    EventEntity findByEventId(Long eventId);




    List<EventEntity> findByOrganizer_UserId(Long organizerId);

    Optional<EventEntity> findByEventIdAndOrganizer_UserId(
            Long eventId,
            Long organizerId
    );

    @Query("""
            SELECT e FROM EventEntity e
            WHERE (
            LOWER(e.title) LIKE LOWER(CONCAT('%',:query, '%'))
            OR LOWER(e.venue) LIKE LOWER(CONCAT('%',:query,'%'))
            )
            
            AND e.status=:status
            AND e.visibility=:visibility
            AND e.startDate>=:today
            """)
    public List<EventEntity> searchEventLive(
            @Param("query") String query,
            @Param("status") EventStatus eventStatus,
            @Param("visibility") EventVisiblity eventVisiblity,
            @Param("today") LocalDate today
    );





    @Modifying
    @Query("""
        UPDATE EventEntity e
        SET e.status = 'PAST'
        WHERE e.status = 'LIVE'
        AND (
            e.endDate < :today
            OR (e.endDate = :today AND e.endTime < :now)
        )
    """)
    int markPastEvents(LocalDate today, LocalTime now);
}

