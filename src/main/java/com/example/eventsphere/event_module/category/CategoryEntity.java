package com.example.eventsphere.event_module.category;

import com.example.eventsphere.event_module.event.EventEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name="category")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CategoryEntity {

   @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
   @Column(nullable = false,length = 100)
    private String categoryName;
   @Column(columnDefinition = "TEXT")
    private String categoryDescription;
   // one event related to many events
   @OneToMany(mappedBy = "category")
    private List<EventEntity> eventList;
}
