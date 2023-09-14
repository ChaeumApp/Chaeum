package com.tls.category.service;

import com.tls.category.entity.Category;
import com.tls.category.repository.CategoryRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    @Override
    public List<Category> getCategories() {
        try {
            return categoryRepository.findAll().orElse(null);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Category getCategory(int catId) {
        try {
            return categoryRepository.findByCatId(catId).orElse(null);
        } catch (Exception e) {
            return null;
        }
    }
}
