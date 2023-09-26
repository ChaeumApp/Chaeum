package com.tls.ingredient;

import java.time.LocalDate;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class IngredientPriceVO {
    int price;
    LocalDate date;
}
