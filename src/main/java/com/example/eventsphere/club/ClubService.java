package com.example.eventsphere.club;

import com.example.eventsphere.event.EventEntity;
import com.example.eventsphere.event.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClubService {

    @Autowired
    private ClubRepository clubRepository;

    @Autowired
    private EventRepository eventRepository;


    // ================================
    // [GTAG] CREATE CLUB
    // ================================
    public ClubEntity createClub(ClubEntity club){

        return clubRepository.save(club);
    }


    // ================================
    // [GTAG] GET ALL CLUBS
    // ================================
    public List<ClubEntity> getAllClubs(){

        return clubRepository.findAll();
    }


    // ================================
    // [GTAG] GET CLUB BY ID
    // ================================
    public ClubEntity getClubById(Long clubId){

        return clubRepository.findById(clubId)
                .orElseThrow(() -> new RuntimeException("Club not found"));
    }


    // ================================
    // [GTAG] UPDATE CLUB
    // ================================
    public ClubEntity updateClub(Long clubId, ClubEntity updatedClub){

        ClubEntity club = getClubById(clubId);

        club.setClubname(updatedClub.getClubname());

        return clubRepository.save(club);
    }


    // ================================
    // [GTAG] DELETE CLUB
    // ================================
    public void deleteClub(Long clubId){

        ClubEntity club = getClubById(clubId);

        clubRepository.delete(club);
    }


    // ================================
    // [GTAG] GET EVENTS OF CLUB
    // ================================
    public List<EventEntity> getClubEvents(Long clubId){

        return eventRepository.findByClub_ClubId(clubId);
    }

}