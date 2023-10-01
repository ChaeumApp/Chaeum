package com.tls.search.dto;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.recipe.entity.single.Recipe;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Builder
@Data
public class SearchDto {

    List<Ingredient> ingrList;
    List<Recipe> recipeList;
}
