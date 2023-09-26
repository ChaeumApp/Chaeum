package com.tls.ingredient.repository;

import com.tls.ingredient.entity.composite.IngredientPreference;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.user.entity.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IngredientPreferenceRepository extends
    JpaRepository<IngredientPreference, Integer> {

    Optional<IngredientPreference> findByUserAndIngredient(User user, Ingredient ingredient);

}
