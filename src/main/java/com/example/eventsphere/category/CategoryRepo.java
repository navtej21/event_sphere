package com.example.eventsphere.category;

import jdk.jfr.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface CategoryRepo extends JpaRepository<CategoryEntity,Long> {

    Optional<CategoryEntity> findBycategoryname(String categoryname);

    boolean existsBycategoryname(String categoryname);

    List<CategoryEntity> findBycategorynameContainingIgnoreCase(String categoryname);



}
