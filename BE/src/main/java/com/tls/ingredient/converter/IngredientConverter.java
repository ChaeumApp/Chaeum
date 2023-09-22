package com.tls.ingredient.converter;

import com.tls.ingredient.dto.IngredientDto;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.category.repository.CategoryRepository;
import com.tls.category.repository.SubCategoryRepository;
import com.tls.ingredient.repository.UserIngrRepository;
import com.tls.user.entity.User;
import com.tls.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class IngredientConverter {

    private final SubCategoryRepository subCategoryRepository;
    private final CategoryRepository categoryRepository;
    private final UserIngrRepository userIngrRepository;
    private final UserRepository userRepository;

    public IngredientDto entityToDto(Ingredient entity) {
        return IngredientDto.builder()
            .ingrName(entity.getIngrName())
            .ingrId(entity.getIngrId())
            .subCategory(
                entity.getSubCategory() != null ? entity.getSubCategory().getSubCatName() : null)
            .category(entity.getCategory().getCatName())
            .savedIngredient(false)
            .build();
    }

    public IngredientDto entityToDto(String userEmail, Ingredient entity) {
        User user = userRepository.findByUserEmail(userEmail).orElse(null);
        boolean saved = userIngrRepository.findByUserIdAndIngrId(user, entity).isPresent();
        return IngredientDto.builder()
            .ingrName(entity.getIngrName())
            .ingrId(entity.getIngrId())
            .subCategory(
                entity.getSubCategory() != null ? entity.getSubCategory().getSubCatName() : null)
            .category(entity.getCategory().getCatName())
            .savedIngredient(saved)
            .build();
    }

    public Ingredient dtoToEntity(IngredientDto dto) {
        return Ingredient.builder()
            .ingrId(dto.getIngrId())
            .ingrName(dto.getIngrName())
            .subCategory(subCategoryRepository.findBySubCatName(dto.getSubCategory()).orElse(null))
            .category(categoryRepository.findByCatName(dto.getCategory()).orElse(null))
            .build();
    }
}
