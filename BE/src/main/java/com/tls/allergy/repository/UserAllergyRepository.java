package com.tls.allergy.repository;


import com.tls.allergy.composite.UserAllergy;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface UserAllergyRepository extends Repository<UserAllergy, String> {

    Optional<UserAllergy> findByUserId(String userId);

    void save(UserAllergy userAllergy);
}
