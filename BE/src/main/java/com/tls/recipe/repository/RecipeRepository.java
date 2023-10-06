package com.tls.recipe.repository;

import com.tls.recipe.entity.single.Recipe;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecipeRepository extends JpaRepository<Recipe, String> {


    Optional<Recipe> findByRecipeId(int recipeId);

    List<Recipe> findByRecipeNameContaining(String recipeName);

}
