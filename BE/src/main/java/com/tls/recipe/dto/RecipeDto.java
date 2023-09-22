package com.tls.recipe.dto;

import java.util.List;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class RecipeDto {

    String recipeName;
    String recipeThumbnail;
    String recipeLink;
    List<String> recipeProcess;
    List<String[]> recipeIngredients;
    boolean savedRecipe;
}
