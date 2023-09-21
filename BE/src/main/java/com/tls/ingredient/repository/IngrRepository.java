package com.tls.ingredient.repository;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.category.entity.Category;
import com.tls.category.entity.SubCategory;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface IngrRepository extends Repository<Ingredient, Integer> {

    Optional<List<Ingredient>> findAll();

    Optional<Ingredient> findByIngrId(int ingrId);

    Optional<List<Ingredient>> findByCategory(Category category);

    Optional<List<Ingredient>> findByCategoryAndSubCategory(Category category,
        SubCategory subCategory);

}
