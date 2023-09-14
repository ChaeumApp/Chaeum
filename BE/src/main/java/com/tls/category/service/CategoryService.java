package com.tls.category.service;

import com.tls.category.entity.Category;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public interface CategoryService {
    List<Category> getCategories();

    Category getCategory(int catId);
}
