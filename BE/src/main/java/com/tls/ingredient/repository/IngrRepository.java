package com.tls.ingredient.repository;

import com.tls.ingredient.entity.single.Ingredient;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface IngrRepository extends Repository<Ingredient, Integer> {

    Optional<Ingredient> findByIngrId(int ingrId);
}
