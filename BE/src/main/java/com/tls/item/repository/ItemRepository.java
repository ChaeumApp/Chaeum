package com.tls.item.repository;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.item.entity.single.Item;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;

public interface ItemRepository extends Repository<Item, String> {

    Optional<List<Item>> findByIngredientAndItemCrawlingDate(Ingredient ingredient, LocalDate localDate);

    Optional<Item> findByItemId(String itemId);
    void save(Item item);

    @Query("SELECT i FROM Item i WHERE i.ingredient = :ingrId AND i.itemCrawlingDate = (SELECT MAX(i2.itemCrawlingDate) FROM Item i2 WHERE i2.ingredient = :ingrId)")
    Optional<List<Item>> findTopByIngrIdOrderByItemCrawlingDateDesc(@Param("ingrId") Ingredient ingrId);

}
