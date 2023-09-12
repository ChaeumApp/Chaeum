package com.tls.allergy.repository;

import com.tls.Ingredient.entity.single.Ingredient;
import com.tls.allergy.composite.AllergyIngredient;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface AllergyIngredientRepository extends Repository<AllergyIngredient, String> {

    Optional<List<AllergyIngredient>> findByAlgyId();

}
