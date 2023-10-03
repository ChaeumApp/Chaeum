package com.tls.ingredient.repository;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.ingredient.entity.single.IngredientPrice;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface IngredientPriceRepository extends JpaRepository<IngredientPrice, Integer> {

    Optional<List<IngredientPrice>> findByIngrIdOrderByDateDesc(Ingredient ingredient);

    @Query("SELECT i " +
        "FROM Ingredient i " +
        "JOIN IngredientPrice pToday ON i.ingrId = pToday.ingrId.ingrId " +
        "JOIN IngredientPrice pYesterday ON i.ingrId = pYesterday.ingrId.ingrId " +
        "WHERE pToday.date = :today AND pYesterday.date = :yesterday AND pToday.price < pYesterday.price " +
        "ORDER BY pYesterday.price - pToday.price DESC")
    List<Ingredient> findTop10PriceDrops(LocalDate today, LocalDate yesterday, Pageable pageable);

}
