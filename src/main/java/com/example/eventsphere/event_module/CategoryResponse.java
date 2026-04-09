package com.example.eventsphere.event_module;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CategoryResponse {

    private Long categoryId;
    private String categoryName;
    private String description;
    private Long eventCount;

}
