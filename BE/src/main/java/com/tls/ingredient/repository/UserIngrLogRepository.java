package com.tls.ingredient.repository;

import com.tls.ingredient.entity.composite.UserIngrLog;
import com.tls.ingredient.entity.single.Ingredient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserIngrLogRepository extends JpaRepository<UserIngrLog, Integer> {

    @Query("SELECT uil.ingrId " +
            "FROM UserIngrLog uil " +
            "GROUP BY uil.ingrId " +
            "ORDER BY COUNT(uil) DESC")
    List<Ingredient> findBestIngredients();
}
