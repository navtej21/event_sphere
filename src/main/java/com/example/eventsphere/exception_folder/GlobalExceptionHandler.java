package com.example.eventsphere.exception_folder;

import lombok.val;
import org.apache.coyote.Response;
import org.checkerframework.checker.units.qual.A;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.method.MethodValidationException;
import org.springframework.web.ErrorResponse;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.nio.file.AccessDeniedException;
import java.time.LocalDateTime;

@RestControllerAdvice
public class GlobalExceptionHandler {

    // resource not found
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ApiError> handleEventNotFound(ResourceNotFoundException ex){

        ApiError apiError=new ApiError();
        apiError.setMessage(ex.getMessage());
        apiError.setTimeStamp(LocalDateTime.now());
        apiError.setStatusId(HttpStatus.NOT_FOUND.value());
        return new ResponseEntity<>(apiError,HttpStatus.NOT_FOUND);
    }




    // user duplication found
    @ExceptionHandler(DuplicateResourceException.class)
    public ResponseEntity<ApiError> handleDuplicateResource(DuplicateResourceException ex){
        ApiError apiError=new ApiError();
        apiError.setStatusId(HttpStatus.CONFLICT.value());
        apiError.setMessage(ex.getMessage());
        apiError.setTimeStamp(LocalDateTime.now());
        return new ResponseEntity<>(apiError,HttpStatus.CONFLICT);
    }

    @ExceptionHandler(MethodValidationException.class)
    public ResponseEntity<ApiError> handleInvalidArguments(MethodValidationException ex){
        ApiError apiError=new ApiError();
        apiError.setMessage(ex.getMessage());
        apiError.setStatusId(HttpStatus.BAD_REQUEST.value());
        apiError.setTimeStamp(LocalDateTime.now());
        return new ResponseEntity<>(apiError,HttpStatus.BAD_REQUEST);
    }



    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ApiError> handleAccessDeniedException(AccessDeniedException ex){
        ApiError apiError=new ApiError();
        apiError.setMessage(ex.getMessage());
        apiError.setTimeStamp(LocalDateTime.now());
        apiError.setStatusId(HttpStatus.FORBIDDEN.value());

        return new ResponseEntity<>(apiError,HttpStatus.FORBIDDEN);
    }


    // event seat insufficient
    @ExceptionHandler(InsufficientException.class)
    public ResponseEntity<ApiError> insufficientCapacity(InsufficientException ex){
        ApiError apiError=new ApiError();
        apiError.setStatusId(HttpStatus.UNPROCESSABLE_ENTITY.value());
        apiError.setTimeStamp(LocalDateTime.now());
        apiError.setMessage(ex.getMessage());
        return new ResponseEntity<>(apiError,HttpStatus.UNPROCESSABLE_ENTITY);
    }




}
