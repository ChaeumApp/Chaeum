package com.tls.Ingredient.service;

import com.tls.Ingredient.dto.IngredientDto;
import com.tls.Ingredient.entity.composite.UserIngr;
import com.tls.Ingredient.repository.IngrRepository;
import com.tls.Ingredient.repository.UserIngrRepository;
import com.tls.Ingredient.vo.IngredientVO;
import com.tls.Ingredient.vo.UserIngrVO;
import com.tls.user.repository.UserRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IngredientServiceImpl implements IngredientService {

    private final UserRepository userRepository;
    private final IngrRepository ingrRepository;
    private final UserIngrRepository userIngrRepository;

    @Override
    public List<IngredientDto> getIngredients() {
        return null;
    }

    @Override
    public List<IngredientDto> getIngredients(int catId, int subCatId) {
        return null;
    }

    public List<IngredientDto> getBestIngredients() {
        return null;
    }

    @Override
    public IngredientDto getIngredient(int ingrId) {
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
    public int favoriteIngredient(String userEmail, int ingrId) {
        try {
            userIngrRepository.save(
                UserIngr.builder()
                    .userId(userRepository.findByUserEmail(userEmail).orElse(null))
                    .ingrId(ingrRepository.findByIngrId(ingrId).orElse(null))
                    .build()
            );
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }
}
