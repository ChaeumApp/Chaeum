package com.tls.allergy.repository;


import com.tls.allergy.entity.composite.UserAllergy;
import com.tls.allergy.id.UserAllergyId;
import com.tls.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import java.util.List;
import java.util.Optional;

public interface UserAllergyRepository extends JpaRepository<UserAllergy, UserAllergyId> {

    Optional<List<UserAllergy>> findAllByUserId(User UserId);

    @Modifying
    void deleteByUserId(User userId);
}
