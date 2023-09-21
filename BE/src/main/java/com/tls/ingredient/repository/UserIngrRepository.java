package com.tls.ingredient.repository;

import com.tls.ingredient.entity.composite.UserIngr;
import com.tls.ingredient.key.UserIngrPK;
import org.springframework.data.repository.Repository;

public interface UserIngrRepository extends Repository<UserIngr, UserIngrPK> {

    void save(UserIngr userIngr);
}
