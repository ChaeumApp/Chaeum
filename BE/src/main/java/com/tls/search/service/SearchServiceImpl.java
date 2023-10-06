package com.tls.search.service;

import com.tls.ingredient.repository.IngredientRepository;
import com.tls.recipe.repository.RecipeRepository;
import com.tls.search.dto.SearchDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SearchServiceImpl implements SearchService {

    private final IngredientRepository ingredientRepository;
    private final RecipeRepository recipeRepository;

    @Override
    public SearchDto searchQuery(String query) {
       return SearchDto.builder()
                .ingrList(ingredientRepository.findByIngrNameContaining(query))
                .recipeList(recipeRepository.findByRecipeNameContaining(query))
                .build();
    }
}
