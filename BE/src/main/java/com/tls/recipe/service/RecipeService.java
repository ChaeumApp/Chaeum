package com.tls.recipe.service;

import com.tls.recipe.entity.single.Recipe;

public interface RecipeService {

    int updateRecipe();

    Recipe viewRecipe(int recipeId);
}
