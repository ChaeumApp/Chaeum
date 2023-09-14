package com.tls.recipe.repository;

import com.tls.recipe.entity.single.Recipe;
import org.springframework.data.repository.Repository;

public interface RecipeRepository extends Repository<Recipe, String> {

    void save(Recipe recipe);
}
