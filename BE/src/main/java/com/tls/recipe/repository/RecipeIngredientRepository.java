package com.tls.recipe.repository;

import com.tls.recipe.entity.composite.RecipeIngr;
import com.tls.recipe.entity.single.Recipe;
import java.util.List;
import org.springframework.data.repository.Repository;

public interface RecipeIngredientRepository extends Repository<RecipeIngr, Long> {
    List<RecipeIngr> findByRecipeId(Recipe recipeId);
}
