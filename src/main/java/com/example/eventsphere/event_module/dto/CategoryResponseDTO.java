package com.example.eventsphere.event_module.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CategoryResponseDTO {

    private Long categoryId;
    private String categoryName;
    private String description;
    private Long eventCount;

}
