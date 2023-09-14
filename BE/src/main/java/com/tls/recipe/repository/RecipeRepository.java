package com.tls.recipe.repository;

import com.tls.recipe.entity.single.Recipe;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface RecipeRepository extends Repository<Recipe, String> {

    Optional<Recipe> findByRecipeId(int recipeId);

    void save(Recipe recipe);
}
