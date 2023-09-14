package com.tls.recipe.service;

import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.repository.RecipeRepository;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RecipeServiceImpl implements RecipeService {

    private final RecipeRepository recipeRepository;

    @Override
    public int updateRecipe() {
        return (int) (Math.random() % 2);
    }

    @Override
    public Recipe viewRecipe(int recipeId) {
        return recipeRepository.findByRecipeId(recipeId).orElse(null);
    }

    @Override
    public List<Recipe> suggestedRecipes(String userEmail) {
        List<Recipe> tmp = new ArrayList<>();
        tmp.add(new Recipe(0, "recipe name", "recipe link", "recipe thumbnail"));
        return tmp;
    }
}
