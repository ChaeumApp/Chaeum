package com.tls.ingredient.repository;

import com.tls.ingredient.entity.composite.IngredientDefaultPreference;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IngredientDefaultPreferenceRepository extends JpaRepository<IngredientDefaultPreference, Integer> {
    Optional<List<IngredientDefaultPreference>> findAllByGroupId(int groupId);
}
