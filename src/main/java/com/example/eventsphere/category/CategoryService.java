package com.example.eventsphere.category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;



@Service
public class CategoryService {

    @Autowired
    private CategoryRepo categoryrepo;


    public CategoryEntity createCategory(CategoryEntity entity){
        if(categoryrepo.existsBycategoryname(entity.getCategoryname())){
            throw new IllegalArgumentException("Category Already exists");
        }

        return categoryrepo.save(entity);
    }


    public List<CategoryEntity> getAllCategories(){
        return categoryrepo.findAll();
    }


    public CategoryEntity getCategorybyId(Long id){
        return categoryrepo.findById(id).orElseThrow(()->new IllegalArgumentException("Not present"));
    }

    public void deleteCategory(Long categoryid){
        if(categoryrepo.findById(categoryid).isEmpty()){
            throw new IllegalArgumentException("Not present");
        }
        categoryrepo.deleteById(categoryid);
    }
}
