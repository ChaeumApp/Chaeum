package com.tls.config;

import com.tls.category.repository.CategoryRepository;
import com.tls.category.repository.SubCategoryRepository;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.ingredient.repository.IngredientRepository;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class VeganConfig {
    private final IngredientRepository ingredientRepository;
    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;
    public List<Ingredient> veganIdToIngredient(int veganId){
        List<Ingredient> results = new ArrayList<>();
        switch (veganId){
            case 1:
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(4).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(5).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(6).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(7).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(9).get()).get());
            case 2:
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(4).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(5).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(7).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(9).get()).get());
            case 3:
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(4).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(5).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(7).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(9).get()).get());
            case 4:
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(4).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(5).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(7).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(9).get()).get());
            case 5:
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(4).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(7).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(9).get()).get());
            case 6:
                results.addAll(ingredientRepository.findByCategoryAndSubCategory(categoryRepository.findByCatId(4).get(), subCategoryRepository.findBySubCatId(1).get()).get());
                results.addAll(ingredientRepository.findByCategoryAndSubCategory(categoryRepository.findByCatId(4).get(), subCategoryRepository.findBySubCatId(2).get()).get());
                results.addAll(ingredientRepository.findByCategoryAndSubCategory(categoryRepository.findByCatId(4).get(), subCategoryRepository.findBySubCatId(5).get()).get());
            case 7:
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(4).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(5).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(6).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(7).get()).get());
                results.addAll(ingredientRepository.findByCategory(categoryRepository.findByCatId(9).get()).get());
        }
        return results;
    }

}
