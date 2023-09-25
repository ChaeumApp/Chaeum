package com.tls.ingredient.service;

import com.tls.ingredient.dto.IngredientDto;
import com.tls.ingredient.vo.IngredientVO;
import java.util.List;

public interface IngredientService {

    List<IngredientDto> getIngredients(String userEmail);

    List<IngredientDto> getIngredients(int catId, int subcatId);

    List<IngredientDto> getBestIngredients();

    IngredientDto getIngredient(String userEmail, int ingrId);

    int selectIngredient(String userEmail, IngredientVO ingredientVO);

    int dislikeIngredient(IngredientVO ingredientVO);

    int favoriteIngredient(String userEmail, int ingrId);
}
