package com.example.eventsphere.event;

import com.example.eventsphere.club.ClubEntity;
import com.example.eventsphere.club.ClubRepository;
import com.example.eventsphere.enums.EventStatus;
import com.example.eventsphere.enums.EventVisiblity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;

    @Autowired
    private ClubRepository clubRepository;


    // ================================
    // [GTAG] ORGANIZER: CREATE EVENT
    // ================================
    public EventEntity createEvent(EventEntity event, Long clubId){

        ClubEntity club = clubRepository.findById(clubId)
                .orElseThrow(() -> new RuntimeException("Club not found"));

        event.setClub(club);
        event.setStatus(EventStatus.INACTIVE);
        event.setVisibility(EventVisiblity.PRIVATE);
        event.setCreatedAt(LocalDateTime.now());
        event.setUpdatedAt(LocalDateTime.now());

        return eventRepository.save(event);
    }


    // ================================
    // [GTAG] ORGANIZER: VIEW CLUB EVENTS
    // ================================
    public List<EventEntity> getClubEvents(Long clubId){

        return eventRepository.findByClub_ClubId(clubId);
    }


    // ================================
    // [GTAG] EVENT INFO
    // ================================
    public EventEntity getEventById(Long eventId){

        return eventRepository.findById(eventId)
                .orElseThrow(() -> new RuntimeException("Event not found"));
    }


    // ================================
    // [GTAG] ORGANIZER: UPDATE EVENT
    // ================================
    @Transactional
    public EventEntity updateEvent(Long eventId, EventEntity updated){

        EventEntity event = getEventById(eventId);

        if(event.getEndDate().isBefore(LocalDate.now())){
            throw new IllegalStateException("Cannot edit past events");
        }

        event.setTitle(updated.getTitle());
        event.setDescription(updated.getDescription());
        event.setStartDate(updated.getStartDate());
        event.setStartTime(updated.getStartTime());
        event.setEndDate(updated.getEndDate());
        event.setEndTime(updated.getEndTime());
        event.setVenue(updated.getVenue());
        event.setCapacity(updated.getCapacity());
        event.setLocation(updated.getLocation());
        event.setImageurl(updated.getImageurl());
        event.setUpdatedAt(LocalDateTime.now());

        return eventRepository.save(event);
    }


    // ================================
    // [GTAG] ORGANIZER: PUBLISH EVENT
    // ================================
    @Transactional
    public EventEntity publishEvent(Long eventId){

        EventEntity event = getEventById(eventId);

        if(event.getStatus() != EventStatus.INACTIVE){
            throw new IllegalStateException("Only draft events can be published");
        }

        event.setStatus(EventStatus.ACTIVE);
        event.setVisibility(EventVisiblity.PUBLIC);
        event.setUpdatedAt(LocalDateTime.now());

        return eventRepository.save(event);
    }


    // ================================
    // [GTAG] ORGANIZER: CANCEL EVENT
    // ================================
    @Transactional
    public void cancelEvent(Long eventId){

        EventEntity event = getEventById(eventId);

        event.setStatus(EventStatus.CANCELLED);
        event.setVisibility(EventVisiblity.PRIVATE);

        eventRepository.save(event);
    }


    // ================================
    // [GTAG] ORGANIZER: DELETE EVENT
    // ================================
    public void deleteEvent(Long eventId){

        EventEntity event = getEventById(eventId);

        if(event.getStatus() == EventStatus.ACTIVE){
            throw new IllegalStateException("Cannot delete active events");
        }

        eventRepository.delete(event);
    }


    // ================================
    // [GTAG] ATTENDEE: VIEW LIVE EVENTS
    // ================================
    public List<EventEntity> getLiveEvents(){

        return eventRepository.findByStatusAndVisibility(
                EventStatus.ACTIVE,
                EventVisiblity.PUBLIC
        );
    }

    // ================================
// [GTAG] ATTENDEE: GET EVENT INFO
// ================================

    public EventEntity getEventInfo(Long eventId){

        EventEntity event=eventRepository.findByEventId(eventId);

        if(event==null){
            throw new RuntimeException("no event found");
        }

        else{
            return event;
        }
    }


    // ================================
// [GTAG] ATTENDEE: SEARCH EVENTS
// ================================


    public  List<EventEntity> searchEvents(String query){
        if(query==null || query.trim().isEmpty()){
            return getLiveEvents();
        }

        return eventRepository.searchEvents(query);
    }

}