package com.tls.Ingredient.service;

import com.tls.Ingredient.dto.IngredientDto;
import com.tls.Ingredient.vo.IngredientVO;
import com.tls.Ingredient.vo.UserIngrVO;
import com.tls.category.vo.CategoryVO;
import java.util.List;

public interface IngredientService {

    List<IngredientDto> getIngredients();

    List<IngredientDto> getIngredients(int catId, int subcatId);

    List<IngredientDto> getBestIngredients();

    IngredientDto getIngredient(int ingrId);

    int selectIngredient(UserIngrVO userIngrVO);

    int dislikeIngredient(IngredientVO ingredientVO);

    int favoriteIngredient(UserIngrVO userIngrVO);
}
