package com.tls.item.dto;

import com.tls.ingredient.entity.single.Ingredient;
import java.io.Serializable;
import java.util.Objects;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ItemDto implements Serializable {

    String itemId;
    String itemName;
    String itemImage;
    int itemPrice;
    String itemStore;
    String itemStoreLink;
    Ingredient ingredient;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ItemDto that = (ItemDto) o;
        return Objects.equals(itemId, that.itemId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(itemId);
    }
}
