package com.tls.recipe.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RecipeServiceImpl implements RecipeService{

    @Override
    public int updateRecipe() {
        return (int) (Math.random() % 2);
    }
}
