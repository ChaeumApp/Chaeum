package com.tls.Ingredient.dto;


import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class IngredientDto {

    int ingrId;
    String ingrName;
    String subCategory;
    String category;
    
    // 가격 정보
}
