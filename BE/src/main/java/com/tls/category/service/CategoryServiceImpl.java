package com.tls.category.service;

import com.tls.category.dto.CategoryWithSubCategoryDto;
import com.tls.category.entity.Category;
import com.tls.category.repository.CategoryRepository;
import com.tls.category.repository.SubCategoryRepository;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;

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

    @Override
    public List<CategoryWithSubCategoryDto> getCategoryWithSubCategory() {
        try {
            List<CategoryWithSubCategoryDto> results = new ArrayList<>();
            getCategories().forEach(category -> {
                System.out.println("---");
                System.out.println(category.getCatName());
                CategoryWithSubCategoryDto categoryWithSubCategoryDto = CategoryWithSubCategoryDto.builder()
                    .catId(category.getCatId())
                    .catName(category.getCatName())
                    .subCategoryDtoList(subCategoryRepository.findByCatId(category))
                    .build();
                System.out.println(categoryWithSubCategoryDto.getCatName());
                results.add(categoryWithSubCategoryDto);
            });
            return results;
        } catch (Exception e) {
            return null;
        }
    }
}
