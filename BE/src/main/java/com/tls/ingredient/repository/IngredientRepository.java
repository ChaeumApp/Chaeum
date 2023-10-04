package com.tls.ingredient.repository;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.category.entity.Category;
import com.tls.category.entity.SubCategory;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

public interface IngredientRepository extends Repository<Ingredient, Integer> {

    Optional<List<Ingredient>> findAll();

    Optional<Ingredient> findByIngrId(int ingrId);

    Optional<List<Ingredient>> findByCategory(Category category);

    List<Ingredient> findByIngrNameContaining(String ingrName);

    Optional<List<Ingredient>> findByCategoryAndSubCategory(Category category,
        SubCategory subCategory);

    int count();

    @Query("SELECT ir.ingredient " +
        "FROM IngredientRecommend ir " +
        "WHERE ir.ingredient.category = :category " +
        "AND ir.ingredient.subCategory = :subCategory " +
        "GROUP BY ir.ingredient " +
        "ORDER BY SUM(ir.ingrRecommendScore) DESC")
    Optional<List<Ingredient>> findTopIngredientByCategoryAndSubCategory(Category category, SubCategory subCategory);

    @Query("SELECT ir.ingredient " +
        "FROM IngredientRecommend ir " +
        "WHERE ir.ingredient.category = :category " +
        "GROUP BY ir.ingredient " +
        "ORDER BY SUM(ir.ingrRecommendScore) DESC")
    Optional<List<Ingredient>> findTopIngredientByCategory(Category category);

}
