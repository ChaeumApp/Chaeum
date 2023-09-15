package com.tls.recipe.service;

import com.tls.recipe.entity.single.Recipe;
import java.util.List;

public interface RecipeService {

    int updateRecipe();

    Recipe viewRecipe(int recipeId);

    List<Recipe> suggestedRecipes(String userEmail);

    int selectRecipe(String userEmail, int recipeId);

    int likeRecipe(String userEmail, int recipeId);

    List<Recipe> findByIngrName(String ingrName);
}
