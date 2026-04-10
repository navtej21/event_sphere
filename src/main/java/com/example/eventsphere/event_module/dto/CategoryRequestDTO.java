package com.example.eventsphere.event_module.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;


@Data
@Builder
public class CategoryRequestDTO {

    @NotBlank(message = "Category name is missing")
    @Size(max = 100,message = "Category must be <=100 characters")
    private String categoryName;
    private String description;
}
