package com.example.eventsphere.user_module;

import com.example.eventsphere.enums.UserRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserProfileResponse {
    private Long userId;
    private String name;
    private String email;
    private UserRole role;
    private String profileImage;
    private LocalDateTime createdAt;
}
