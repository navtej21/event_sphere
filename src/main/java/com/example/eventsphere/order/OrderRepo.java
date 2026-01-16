package com.example.eventsphere.order;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface OrderRepo extends JpaRepository<OrderEntity,Long> {



}
