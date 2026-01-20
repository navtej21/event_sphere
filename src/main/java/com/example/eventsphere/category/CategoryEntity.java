package com.example.eventsphere.category;


import com.example.eventsphere.event.EventEntity;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "category")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CategoryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long categoryid;

    @Column(nullable = false)
    private String categoryname;

    @OneToMany(mappedBy = "category",cascade = CascadeType.ALL)
    private List<EventEntity> eventlist=new ArrayList<>();

}
