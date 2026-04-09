package com.example.eventsphere.enums;

import lombok.Getter;

@Getter
public enum UserRole {

    ATTENDEE("Attendee"),
    ORGANIZER("Organizer"),
    ADMIN("Admin");
    private final String label;

    UserRole(String label){
        this.label=label;
    }


    public String getLabel(){
        return label;
    }
}
