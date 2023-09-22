package com.tls.ingredient.repository;

import com.tls.ingredient.entity.composite.UserIngrLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserIngrLogRepository extends JpaRepository<UserIngrLog, Integer> {

}
