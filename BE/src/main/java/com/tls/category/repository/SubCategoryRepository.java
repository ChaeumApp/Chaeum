package com.tls.category.repository;

import com.tls.category.entity.SubCategory;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface SubCategoryRepository extends Repository<SubCategory, String> {
    Optional<SubCategory> findBySubCatId(String subCatId);

    void save(SubCategory subCategory);
}
