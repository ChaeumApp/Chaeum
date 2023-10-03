package com.tls.ingredient.service;

import com.tls.ingredient.IngredientPriceVO;
import com.tls.ingredient.dto.IngredientDto;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.ingredient.vo.IngredientVO;
import com.tls.recipe.entity.single.Recipe;
import java.util.List;

public interface IngredientService {

    List<IngredientDto> getIngredients(String userEmail);

    List<IngredientDto> getIngredients(int catId, int subCatId, String userEmail);
    List<IngredientDto> getIngredientsOrderByScore(int catId, int subCatId, String userEmail);

    List<Ingredient> getBestIngredients();

    IngredientDto getIngredient(String userEmail, int ingrId);

    int selectIngredient(String userEmail, IngredientVO ingredientVO);

    int dislikeIngredient(String userEmail, IngredientVO ingredientVO);

    int favoriteIngredient(String userEmail, int ingrId);

    List<IngredientPriceVO> getPriceList(int ingrId);

    List<Recipe> getRelatedRecipeList(int ingrId);
}
