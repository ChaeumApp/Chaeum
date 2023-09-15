package com.tls.recipe.repository;

import com.tls.recipe.entity.composite.UserRecipe;
import com.tls.recipe.id.UserRecipeId;
import java.util.Optional;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.Repository;

public interface UserRecipeRepository extends Repository<UserRecipe, UserRecipeId> {

    Optional<UserRecipe> findByUserRecipeId(UserRecipeId userRecipeId);

    void save(UserRecipe userRecipe);

    @Modifying
    void deleteByUserRecipeId(UserRecipeId userRecipeId);
}
