package com.tls.category.dto;

import com.tls.category.entity.SubCategory;
import java.util.List;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class CategoryWithSubCategoryDto {

    int catId;
    String catName;
    List<SubCategory> subCategoryDtoList;
}
