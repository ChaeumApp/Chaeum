package com.tls.ingredient.service;

import com.tls.ingredient.dto.IngredientDto;
import com.tls.ingredient.vo.IngredientVO;
import com.tls.ingredient.vo.UserIngrVO;
import java.util.List;

public interface IngredientService {

    List<IngredientDto> getIngredients();

    List<IngredientDto> getIngredients(int catId, int subcatId);

    List<IngredientDto> getBestIngredients();

    IngredientDto getIngredient(int ingrId);

    int selectIngredient(String userEmail, UserIngrVO userIngrVO);

    int dislikeIngredient(IngredientVO ingredientVO);

    int favoriteIngredient(String userEmail, int ingrId);
}
