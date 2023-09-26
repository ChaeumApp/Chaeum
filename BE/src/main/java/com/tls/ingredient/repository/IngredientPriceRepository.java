package com.tls.ingredient.repository;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.ingredient.entity.single.IngredientPrice;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IngredientPriceRepository extends JpaRepository<IngredientPrice, Integer> {

    Optional<List<IngredientPrice>> findByIngrId(Ingredient ingredient);

}
