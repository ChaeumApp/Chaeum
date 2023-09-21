package com.tls.allergy.repository;


import com.tls.allergy.entity.composite.UserAllergy;
import com.tls.allergy.id.UserAllergyId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserAllergyRepository extends JpaRepository<UserAllergy, UserAllergyId> {


}
