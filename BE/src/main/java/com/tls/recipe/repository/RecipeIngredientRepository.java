package com.tls.recipe.repository;

import com.tls.recipe.entity.composite.RecipeIngr;
import com.tls.recipe.entity.single.Recipe;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RecipeIngredientRepository extends JpaRepository<RecipeIngr, Long> {
    List<RecipeIngr> findByRecipeId(Recipe recipeId);
    @Query("SELECT DISTINCT r FROM RecipeIngr ri JOIN ri.recipeId r WHERE ri.RecipeIngrName LIKE %?1%")
    List<Recipe> findDistinctRecipesByIngredientNameContains(String ingredientName);
}
