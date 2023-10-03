package com.tls.ingredient.dto;

import com.tls.ingredient.entity.single.Ingredient;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class IngredientPriceDropDto {

    private Ingredient ingredient;
    private int priceDropAmount;
    private double priceDropPercentage;

    public IngredientPriceDropDto(Ingredient ingredient, int priceDropAmount, int tempPriceDropPercentage) {
        this.ingredient = ingredient;
        this.priceDropAmount = priceDropAmount;
        this.priceDropPercentage = (double) tempPriceDropPercentage;
    }

}