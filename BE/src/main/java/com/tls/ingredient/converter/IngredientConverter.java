package com.tls.Ingredient.converter;

import com.tls.Ingredient.dto.IngredientDto;
import com.tls.Ingredient.entity.single.Ingredient;
import com.tls.category.repository.CategoryRepository;
import com.tls.category.repository.SubCategoryRepository;
import org.springframework.stereotype.Component;

@Component
public class IngredientConverter {

    private SubCategoryRepository subCategoryRepository;
    private CategoryRepository categoryRepository;

    public IngredientDto entityToDto(Ingredient entity) {
        return IngredientDto.builder()
            .ingrName(entity.getIngrName())
            .ingrId(entity.getIngrId())
            .subCategory(
                entity.getSubCategory() != null ? entity.getSubCategory().getSubCatName() : null)
            .category(entity.getCategory().getCatName())
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
