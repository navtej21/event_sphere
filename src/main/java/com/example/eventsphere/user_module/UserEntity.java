package com.example.eventsphere.user_module;


import com.example.eventsphere.enums.UserRole;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name="users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
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


    @Column
    private String profileImage;

    @Column
    private LocalDateTime createdAt= LocalDateTime.now();

}
