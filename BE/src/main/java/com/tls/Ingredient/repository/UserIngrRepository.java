package com.tls.Ingredient.repository;

import com.tls.Ingredient.entity.composite.UserIngr;
import com.tls.Ingredient.key.UserIngrPK;
import com.tls.user.entity.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface UserIngrRepository extends Repository<UserIngr, UserIngrPK> {

    Optional<List<UserIngr>> findAllByUserId(User userId);
    void save(UserIngr userIngr);
}
