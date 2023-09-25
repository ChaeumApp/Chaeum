package com.tls.recipe.repository;

import com.tls.recipe.entity.single.Recipe;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface RecipeRepository extends Repository<Recipe, String> {

    List<Recipe> findAll();

    Optional<Recipe> findByRecipeId(int recipeId);

    List<Recipe> findByRecipeNameContaining(String recipeName);

    void save(Recipe recipe);

}
