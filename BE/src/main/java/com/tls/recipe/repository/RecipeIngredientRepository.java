package com.tls.recipe.repository;

import com.tls.recipe.entity.composite.RecipeIngr;
import com.tls.recipe.entity.single.Recipe;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecipeIngredientRepository extends JpaRepository<RecipeIngr, Long> {
    List<RecipeIngr> findByRecipeId(Recipe recipeId);
}
