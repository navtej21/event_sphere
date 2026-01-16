package com.example.eventsphere.event;

import com.example.eventsphere.enums.EventFeeType;
import com.example.eventsphere.enums.EventStatus;
import com.example.eventsphere.enums.EventVisiblity;
import com.example.eventsphere.user.UserEntity;
import com.example.eventsphere.user.UserRepo;
import jdk.jfr.Event;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;

    // CREATE
    public EventEntity createEvent(EventEntity event, UserEntity organizer) {
        event.setFee(0d);
        event.setFeeType(EventFeeType.FREE);
        event.setOrganizer(organizer);
        event.setStatus(EventStatus.DRAFT);
        event.setVisibility(EventVisiblity.PRIVATE);
        return eventRepository.save(event);
    }


    public EventEntity getEventInfo(Long eventId){
        return eventRepository.findById(eventId).orElseThrow(()->{
            return new IllegalArgumentException("No event found");
        });
    }

    // UPDATE
    public EventEntity updateEvent(Long eventId, EventEntity updated, Long organizerId) {
        EventEntity event = getOrganizerEvent(eventId, organizerId);

        if (event.getStatus() == EventStatus.PAST) {
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
        event.setCategory(updated.getCategory());
        event.setLocation(updated.getLocation());
        event.setImageurl(updated.getImageurl());
        event.setUpdatedAt(LocalDateTime.now());

        return eventRepository.save(event);
    }

    // PUBLISH
    public EventEntity publishEvent(Long eventId, Long organizerId) {
        EventEntity event = getOrganizerEvent(eventId, organizerId);

        if (event.getStatus() != EventStatus.DRAFT) {
            throw new IllegalStateException("Only draft events can be published");
        }

        event.setStatus(EventStatus.LIVE);
        event.setVisibility(EventVisiblity.PUBLIC);
        event.setUpdatedAt(LocalDateTime.now());

        return eventRepository.save(event);
    }

    // CANCEL (NOT DELETE)
    public void cancelEvent(Long eventId, Long organizerId) {
        EventEntity event = getOrganizerEvent(eventId, organizerId);

        event.setStatus(EventStatus.CANCELLED);
        event.setVisibility(EventVisiblity.PRIVATE);
        event.setUpdatedAt(LocalDateTime.now());

        eventRepository.save(event);
    }

    // DELETE
    public void deleteEvent(Long eventId, Long organizerId) {
        EventEntity event = getOrganizerEvent(eventId, organizerId);

        if (event.getStatus() != EventStatus.DRAFT) {
            throw new IllegalStateException("Only draft events can be deleted");
        }

        eventRepository.delete(event);
    }

    // PUBLIC
    public List<EventEntity> getLiveEvents() {
        return eventRepository.findByStatusAndVisibility(
                EventStatus.LIVE,
                EventVisiblity.PUBLIC
        );
    }

    public List<EventEntity> getDraftEvents(){
        return eventRepository.findByStatusAndVisibility(
                EventStatus.DRAFT,
                EventVisiblity.PRIVATE
        );
    }

    public EventEntity getPublicEvent(Long eventId) {
        return eventRepository
                .findByEventIdAndStatusAndVisibility(
                        eventId,
                        EventStatus.DRAFT,
                        EventVisiblity.PRIVATE

                )
                .orElseThrow(() -> new RuntimeException("Event not found"));
    }

    // ORGANIZER
    public List<EventEntity> getOrganizerEvents(Long organizerId) {
        return eventRepository.findByOrganizer_UserId(organizerId);
    }

    // INTERNAL
    private EventEntity getOrganizerEvent(Long eventId, Long organizerId) {
        return eventRepository
                .findByEventIdAndOrganizer_UserId(eventId, organizerId)
                .orElseThrow(() -> new RuntimeException("Unauthorized access"));
    }

    public void autoCompletePastEvents() {
        eventRepository.markPastEvents(
                LocalDate.now(),
                LocalTime.now()
        );
    }

    public boolean checkAvailablity(Long eventid,int quantity){

        EventEntity event=eventRepository.findByEventId(eventid);

        return event.getAvailable()>=quantity;
    }

    public boolean reduceAvailableSeats(Long eventid,int  quantity){


        if(checkAvailablity(eventid,quantity)){
            EventEntity event=eventRepository.findByEventId(eventid);

            event.setAvailable(event.getAvailable()-quantity);

            return true;
        }

        else{
            return false;
        }
    }


    public List<EventEntity> searchEvents(String query)
    {
        if(query==null || query.trim().isEmpty()){
            return getLiveEvents();
        }

        return eventRepository.searchEventLive(
                query,EventStatus.LIVE,EventVisiblity.PUBLIC,LocalDate.now()
        );
    }


}
