package com.example.eventsphere.event;


import com.example.eventsphere.club.ClubEntity;
import com.example.eventsphere.user.UserEntity;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Entity
@Data
@Builder
public class ClubMember {

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "club_id")
    private ClubEntity club;

    @ManyToOne
    @JoinColumn(name="user_id")
    private UserEntity user;
    // COORDINATOR or MEMBER
}