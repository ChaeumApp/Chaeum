package com.tls.Ingredient.controller;

import com.tls.Ingredient.dto.IngredientDto;
import com.tls.Ingredient.service.IngredientService;
import com.tls.Ingredient.vo.IngredientVO;
import com.tls.Ingredient.vo.UserIngrVO;
import com.tls.category.vo.CategoryVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Tag(name = "소분류 API", description = "소분류 관련 API 입니다.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/ingr")
public class IngredientController {

    private final IngredientService ingredientService;

    @PostMapping
    @Operation(summary = "전체 소분류를 조회하는 메서드", description = "저장된 전체 소분류를 조회합니다.", tags = "소분류 API")
    public ResponseEntity<?> getIngredients() {
        log.info("getIngredients call :: ");
        List<IngredientDto> ingredientDtoList = ingredientService.getIngredients();
        if (ingredientDtoList != null) {
            return new ResponseEntity<>(ingredientDtoList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping
    @Operation(summary = "대분류 ID와 중분류 ID로 소분류를 조회하는 메서드",
        description = "대분류 ID와 중분류 ID로 해당하는 소분류를 조회합니다.", tags = "소분류 API")
    public ResponseEntity<?> getIngredientsByCatAndSubCat(CategoryVO categoryVO) {
        log.info("getIngredients call :: ");
        List<IngredientDto> ingredientDtoList = ingredientService.getIngredients(categoryVO);
        if (ingredientDtoList != null) {
            return new ResponseEntity<>(ingredientDtoList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/detail")
    @Operation(summary = "소분류를 조회하는 메서드", description = "소분류 ID로 해당 소분류를 조회합니다.")
    public ResponseEntity<?> getIngredient(IngredientVO ingredientVO) {
        log.info("getIngredient call :: ");
        IngredientDto ingredientDto = ingredientService.getIngredient(ingredientVO);
        if (ingredientDto != null) {
            return new ResponseEntity<>(ingredientDto, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/selected")
    @Operation(summary = "소분류 선택 반영 메서드", description = "사용자가 특정 소분류를 선택한 내용을 저장합니다.", tags = "소분류 API")
    public ResponseEntity<?> selectIngredient(UserIngrVO userIngrVO) {
        log.info("selectIngredient call :: ");
        int n = ingredientService.selectIngredient(userIngrVO);
        if (n == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/dislike")
    @Operation(summary = "소분류 관심없음 반영 메서드", description = "사용자가 특정 소분류를 관심없음 설정한 내용을 저장합니다.", tags = "소분류 API")
    public ResponseEntity<?> dislikeIngredient(IngredientVO ingredientVO) {
        log.info("dislikeIngredient call :: ");
        int n = ingredientService.dislikeIngredient(ingredientVO);
        if (n == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/favorite")
    @Operation(summary = "소분류 좋아요 반영 메서드", description = "사용자가 특정 식재료를 좋아요 설정한 내용을 저장합니다.", tags = "소분류 API")
    public ResponseEntity<?> favoriteIngredient(UserIngrVO userIngrVO) {
        log.info("favoriteIngredient call :: ");
        int n = ingredientService.favoriteIngredient(userIngrVO);
        if (n == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }
}
