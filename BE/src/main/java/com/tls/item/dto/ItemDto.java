package com.tls.item.dto;

import com.tls.ingredient.entity.single.Ingredient;
import lombok.Builder;

@Builder
public class ItemDto {

    long itemId;
    String itemName;
    String itemImage;
    int itemPrice;
    String itemStore;
    String itemStoreLink;
    Ingredient ingredient;
}
