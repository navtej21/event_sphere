package com.example.eventsphere.club;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface ClubRepository extends JpaRepository<ClubEntity, Long> {

    Optional<ClubEntity> findByClubname(String clubname);

}