package com.tls.Ingredient.service;

import com.tls.Ingredient.dto.IngredientDto;
import com.tls.Ingredient.vo.IngredientVO;
import com.tls.Ingredient.vo.UserIngrVO;
import com.tls.category.vo.CategoryVO;
import java.util.List;

public interface IngredientService {

    public IngredientDto getIngredients();

    public List<IngredientDto> getIngredients(CategoryVO categoryVO);

    public IngredientDto getIngredient(IngredientVO ingredientVO);

    public int selectIngredient(UserIngrVO userIngrVO);

    public int dislikeIngredient(IngredientVO ingredientVO);

    public int favoriteIngredient(UserIngrVO userIngrVO);
}
