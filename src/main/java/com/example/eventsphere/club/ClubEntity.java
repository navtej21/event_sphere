package com.example.eventsphere.club;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "club")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ClubEntity {


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long clubId;
    private String clubname;
}
