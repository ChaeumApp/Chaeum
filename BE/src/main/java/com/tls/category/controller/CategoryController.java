package com.tls.category.controller;

import com.tls.category.dto.CategoryWithSubCategoryDto;
import com.tls.category.entity.Category;
import com.tls.category.service.CategoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Tag(name = "분류 API", description = "분류 관련 API 입니다.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/category")
public class CategoryController {

    private final CategoryService categoryService;

    @GetMapping
    @Operation(summary = "대분류 전체 조회 메서드", description = "전체 대분류를 조회하는 메서드입니다.", tags = "분류 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "대분류 전체 조회 성공하면 ok를, 실패하면 fail을 반환한다.")
    })
    public ResponseEntity<?> getCategories() {
        List<Category> categories = categoryService.getCategories();
        if (categories != null) {
            return new ResponseEntity<>(categories, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping
    @Operation(summary = "대분류 조회 메서드", description = "대분류를 ID로 조회하는 메서드입니다.", tags = "분류 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "대분류 조회 성공하면 ok를, 실패하면 fail을 반환한다.")
    })
    public ResponseEntity<?> getCategory(@RequestBody int catId) {
        Category category = categoryService.getCategory(catId);
        if (category != null) {
            return new ResponseEntity<>(category, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/subcat")
    @Operation(summary = "대분류 with 중분류 조회 메서드", description = "대분류를 중분류와 묶어서 조회하는 메서드입니다.", tags = "분류 API")
    @ApiResponse(responseCode = "200", description = "조회 성공하면 List 를, 실패하면 fail 을 반환한다.")
    public ResponseEntity<?> getCategoryWithSubCat() {
        List<CategoryWithSubCategoryDto> results = categoryService.getCategoryWithSubCategory();
        if (results != null) {
            return new ResponseEntity<>(results, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }
}
