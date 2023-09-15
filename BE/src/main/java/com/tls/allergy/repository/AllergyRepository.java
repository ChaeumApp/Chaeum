package com.tls.allergy.repository;

import com.tls.allergy.single.Allergy;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface AllergyRepository extends Repository<Allergy, String> {

    Optional<Allergy> findByAlgyId(int algyId);

    Optional<List<Allergy>> findAll();
}
