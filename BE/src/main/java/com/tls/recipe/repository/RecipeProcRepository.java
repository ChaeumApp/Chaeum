package com.tls.recipe.repository;

import com.tls.recipe.entity.composite.RecipeProc;
import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.id.RecipeProcId;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecipeProcRepository extends JpaRepository<RecipeProc, RecipeProcId> {
    List<RecipeProc> findByRecipeId(Recipe recipe);
}
