package com.tls.Ingredient.service;

import com.tls.Ingredient.converter.IngredientConverter;
import com.tls.Ingredient.dto.IngredientDto;
import com.tls.Ingredient.entity.composite.UserIngr;
import com.tls.Ingredient.entity.single.Ingredient;
import com.tls.Ingredient.repository.IngrRepository;
import com.tls.Ingredient.repository.UserIngrRepository;
import com.tls.Ingredient.vo.IngredientVO;
import com.tls.Ingredient.vo.UserIngrVO;
import com.tls.category.repository.CategoryRepository;
import com.tls.category.repository.SubCategoryRepository;
import com.tls.user.entity.User;
import com.tls.user.repository.UserRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class IngredientServiceImpl implements IngredientService {

    private final UserRepository userRepository;
    private final IngrRepository ingrRepository;
    private final UserIngrRepository userIngrRepository;
    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;
    private final IngredientConverter ingredientConverter = new IngredientConverter();

    @Override
    public List<IngredientDto> getIngredients() {
        List<IngredientDto> results = new ArrayList<>();
        try {
            ingrRepository.findAll().orElseThrow().forEach(ingredient ->
                results.add(ingredientConverter.entityToDto(ingredient))
            );
        } catch (Exception e) {
            return null;
        }
        return results;
    }

    @Override
    public List<IngredientDto> getIngredients(int catId, int subCatId) {
        List<IngredientDto> results = new ArrayList<>();
        try {
            if (subCatId == 0) {
                Objects.requireNonNull(ingrRepository.findByCategory(
                        categoryRepository.findByCatId(catId).orElseThrow()).orElse(null))
                    .forEach(
                        ingredient -> results.add(ingredientConverter.entityToDto(ingredient)));
            } else {
                Objects.requireNonNull(ingrRepository.findByCategoryAndSubCategory(
                        categoryRepository.findByCatId(catId).orElseThrow(),
                        subCategoryRepository.findBySubCatId(subCatId).orElseThrow()).orElse(null))
                    .forEach(
                        ingredient -> results.add(ingredientConverter.entityToDto(ingredient)));
            }
            return results;
        } catch (Exception e) {
            return null;
        }
    }

    public List<IngredientDto> getBestIngredients() {
        return null;
    }

    @Override
    public IngredientDto getIngredient(int ingrId) {
        try {
            return ingredientConverter.entityToDto(
                ingrRepository.findByIngrId(ingrId).orElseThrow());
        } catch (Exception e) {
            return null;
        }
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
    @Transactional
    public int favoriteIngredient(String userEmail, int ingrId) {
        try {
            User user = userRepository.findByUserEmail(userEmail).orElse(null);
            Ingredient ingredient = ingrRepository.findByIngrId(ingrId).orElse(null);
            if (userIngrRepository.findByUserIdAndIngrId(user, ingredient).isPresent()) {
                userIngrRepository.deleteByUserIdAndIngrId(user, ingredient);
            } else {
                userIngrRepository.save(
                    UserIngr.builder()
                        .userId(user)
                        .ingrId(ingredient)
                        .build()
                );
            }
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }
}
