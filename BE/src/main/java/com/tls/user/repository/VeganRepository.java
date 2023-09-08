package com.tls.user.repository;

import com.tls.user.entity.Vegan;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface VeganRepository extends Repository<Vegan, String> {
    Optional<Vegan> findByVeganId(int VeganId);
}
