package com.example.eventsphere.exception_folder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApiError {

    private int statusId;
    private String message;
    private LocalDateTime timeStamp;
}
