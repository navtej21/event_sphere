package com.example.eventsphere.exception;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;


@Data
@Builder
public class ErrorResponse {

    private String message;
    private int status;
    private LocalDateTime timestamp;

    public ErrorResponse(String message,int status,LocalDateTime timestamp){
        this.message=message;
        this.status=status;
        this.timestamp=timestamp;
    }
}
