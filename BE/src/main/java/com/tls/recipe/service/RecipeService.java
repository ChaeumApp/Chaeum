package com.tls.recipe.service;

import com.tls.recipe.entity.single.Recipe;
import java.util.List;

public interface RecipeService {

    int updateRecipe();

    Recipe viewRecipe(int recipeId);

    List<Recipe> suggestedRecipes(String userEmail);
}
