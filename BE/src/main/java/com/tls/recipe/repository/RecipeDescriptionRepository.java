package com.tls.recipe.repository;

import com.tls.recipe.entity.single.RecipeDesc;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RecipeDescriptionRepository extends JpaRepository<RecipeDesc, Integer> {
    Optional<RecipeDesc> findByRecipeId(int recipeId);
}
