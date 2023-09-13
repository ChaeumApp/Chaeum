package com.tls.category.repository;

import com.tls.category.entity.Category;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

@org.springframework.stereotype.Repository
public interface CategoryRepository extends Repository<Category, String> {

    Optional<Category> findByCatId(int catId);

    Optional<List<Category>> findAll();

    void save(Category category);
}
