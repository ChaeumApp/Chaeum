package com.tls.item.repository;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.item.entity.single.Item;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface ItemRepository extends Repository<Item, String> {

    Optional<List<Item>> findByIngredient(Ingredient ingredient);

    Optional<Item> findByItemId(long itemId);
    void save(Item item);
}
