package com.tls.recipe.repository;

import com.tls.recipe.entity.composite.UserRecipeLog;
import com.tls.recipe.id.UserRecipeLogId;
import org.springframework.data.repository.Repository;

public interface UserRecipeLogRepository extends Repository<UserRecipeLog, UserRecipeLogId> {
    void save(UserRecipeLog userRecipeLog);
}
