package com.tls.Ingredient.service;

import com.tls.Ingredient.dto.IngredientDto;
import com.tls.Ingredient.vo.IngredientVO;
import com.tls.Ingredient.vo.UserIngrVO;
import com.tls.category.vo.CategoryVO;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IngredientServiceImpl implements IngredientService {

    @Override
    public IngredientDto getIngredients() {
        return null;
    }

    @Override
    public List<IngredientDto> getIngredients(CategoryVO categoryVO) {
        return null;
    }

    @Override
    public IngredientDto getIngredient(IngredientVO ingredientVO) {
        return null;
    }

    @Override
    public int selectIngredient(UserIngrVO userIngrVO) {
        return 0;
    }

    @Override
    public int dislikeIngredient(IngredientVO ingredientVO) {
        return 0;
    }

    @Override
    public int favoriteIngredient(UserIngrVO userIngrVO) {
        return 0;
    }
}
