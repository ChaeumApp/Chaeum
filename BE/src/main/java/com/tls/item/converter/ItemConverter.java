package com.tls.item.converter;

import com.tls.item.dto.ItemDto;
import com.tls.item.entity.single.Item;

public class ItemConverter {
    public ItemDto entityToDto(Item item){
        return ItemDto.builder()
            .itemId(item.getItemId())
            .itemImage(item.getItemImage())
            .itemName(item.getItemName())
            .itemPrice(item.getItemPrice())
            .itemStore(item.getItemStore())
            .itemStoreLink(item.getItemStoreLink())
            .ingredient(item.getIngredient())
            .build();
    }
}
