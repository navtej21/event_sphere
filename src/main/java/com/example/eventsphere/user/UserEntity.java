package com.example.eventsphere.user;


import com.example.eventsphere.enums.UserRole;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.annotation.processing.Generated;

@Entity
@Table(name="users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserEntity {


    @Id
    @GeneratedValue
    private Long userId;
    @Column
    private String email;
    @Column
    private String name;

    @Column
    private String password;

    @Enumerated(EnumType.STRING)
    private UserRole roles=UserRole.ATTENDEE;

}
