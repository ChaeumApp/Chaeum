package com.tls.allergy.repository;

import com.tls.allergy.entity.composite.AllergyIngredient;
import com.tls.allergy.entity.single.Allergy;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface AllergyIngredientRepository extends Repository<AllergyIngredient, String> {

    List<AllergyIngredient> findByAlgyId(Allergy allergy);

}
