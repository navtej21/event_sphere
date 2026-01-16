package com.example.eventsphere.user;


import com.example.eventsphere.enums.UserRole;
import lombok.Data;

@Data
public class RegisterRequest {

    private String name;
    private String email;
    private String password;
    private UserRole role;
}
