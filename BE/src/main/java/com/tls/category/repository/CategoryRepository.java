package com.tls.category.repository;

import com.tls.category.entity.Category;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface CategoryRepository extends Repository<Category, String> {

    Optional<Category> findByCatId(String catId);

    void save(Category category);
}
