package com.tls.recipe.repository;

import com.tls.recipe.entity.composite.UserRecipe;
import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.id.UserRecipeId;
import com.tls.user.entity.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.Repository;

public interface UserRecipeRepository extends Repository<UserRecipe, UserRecipeId> {

    Optional<UserRecipe> findByUserIdAndRecipeId(User userId, Recipe recipeId);

    void save(UserRecipe userRecipe);

    @Modifying
    void deleteByUserIdAndRecipeId(User userId, Recipe recipeId);
}
