package com.tls.category.service;

import com.tls.category.entity.Category;
import java.util.List;

public interface CategoryService {

    List<Category> getCategories();

    Category getCategory(int catId);
}
