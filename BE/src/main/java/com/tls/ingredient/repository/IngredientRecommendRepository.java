package com.tls.ingredient.repository;

import com.tls.ingredient.entity.composite.IngredientRecommend;
import com.tls.user.entity.User;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IngredientRecommendRepository extends JpaRepository<IngredientRecommend, Integer> {
    List<IngredientRecommend> findByUserOrderByIngrRecommendScoreDesc(User user);
    List<IngredientRecommend> findTop10ByUserOrderByIngrRecommendScoreDesc(User user, Pageable pageable);
}
