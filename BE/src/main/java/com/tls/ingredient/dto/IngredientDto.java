package com.tls.ingredient.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class IngredientDto {

    int ingrId;
    String ingrName;
    String subCategory;
    String category;
    boolean savedIngredient;
    // 가격 정보
}
