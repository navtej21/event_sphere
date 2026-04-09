package com.example.eventsphere.user_module;

import lombok.Data;

@Data
public class LoginRequest {
    private String email;
    private String password;
}