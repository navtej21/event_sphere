package com.example.eventsphere.event_module;

import com.example.eventsphere.exception.CategoryNotFound;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepo categoryRepo;



    // create category
    public CategoryEntity createCategory(CategoryRequest dto){
        CategoryEntity categoryEntity= new CategoryEntity();
        categoryEntity.setCategoryName(dto.getCategoryName());
        categoryEntity.setCategoryDescription(dto.getDescription());

        return categoryRepo.save(categoryEntity);
    }

    // list all the category
    public List<CategoryEntity> getAllCategories(){
        return categoryRepo.findAll();
    }


    // get the category by it"s id
    public CategoryEntity getCategoryById(Long id){

        return categoryRepo.findById(id).orElseThrow(()->{
            throw new CategoryNotFound("Category Not Found exceptipn");
        });
    }


    // delete the category by it"s id
    public void deleteCategory(Long id){

        CategoryEntity category=categoryRepo.findById(id).orElseThrow(()->{
            throw new CategoryNotFound("Category Not Found");
        });
        categoryRepo.delete(category);
    }



}
