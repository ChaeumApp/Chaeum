package com.tls.Ingredient.repository;

import com.tls.Ingredient.entity.single.Ingredient;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface IngrRepository extends Repository<Ingredient, Integer> {

    Optional<Ingredient> findByIngrId(int ingrId);
}
