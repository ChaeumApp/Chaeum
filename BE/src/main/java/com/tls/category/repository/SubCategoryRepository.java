package com.tls.category.repository;

import com.tls.category.entity.Category;
import com.tls.category.entity.SubCategory;
import java.util.List;
import org.springframework.data.repository.Repository;

public interface SubCategoryRepository extends Repository<SubCategory, Integer> {


    List<SubCategory> findByCatId(Category catId);

    void save(SubCategory subCategory);
}
