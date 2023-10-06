package com.tls.category.repository;

import com.tls.category.entity.Category;
import com.tls.category.entity.SubCategory;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface SubCategoryRepository extends Repository<SubCategory, Integer> {


    List<SubCategory> findByCatId(Category catId);

    Optional<SubCategory> findBySubCatId(Integer subCatId);

    Optional<SubCategory> findBySubCatName(String name);

    void save(SubCategory subCategory);
}
