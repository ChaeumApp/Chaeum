package com.tls.ingredient.repository;

import com.tls.ingredient.entity.composite.UserIngr;
import com.tls.ingredient.key.UserIngrPK;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.user.entity.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface UserIngrRepository extends Repository<UserIngr, UserIngrPK> {

    Optional<List<UserIngr>> findAllByUserId(User userId);

    Optional<UserIngr> findByUserIdAndIngrId(User userId, Ingredient ingredient);
    void save(UserIngr userIngr);

    void deleteByUserIdAndIngrId(User userId, Ingredient ingredient);
}
