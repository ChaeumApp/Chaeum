package com.tls.allergy.repository;

import com.tls.allergy.entity.single.Allergy;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface AllergyRepository extends Repository<Allergy, Integer> {

    Optional<Allergy> findByAlgyId(int algyId);

    Optional<List<Allergy>> findAll();
}
