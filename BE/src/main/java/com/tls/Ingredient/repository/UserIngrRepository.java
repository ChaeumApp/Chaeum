package com.tls.Ingredient.repository;

import com.tls.Ingredient.entity.composite.UserIngr;
import com.tls.Ingredient.key.UserIngrPK;
import org.springframework.data.repository.Repository;

public interface UserIngrRepository extends Repository<UserIngr, UserIngrPK> {

    void save(UserIngr userIngr);
}
