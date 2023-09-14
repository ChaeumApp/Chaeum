package com.tls.Ingredient.controller;

import com.tls.Ingredient.dto.IngredientDto;
import com.tls.Ingredient.service.IngredientService;
import com.tls.Ingredient.vo.IngredientVO;
import com.tls.Ingredient.vo.UserIngrVO;
import com.tls.category.vo.CategoryVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
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

//    @PostMapping
//    @Operation(summary = "", description = "")
//    public ResponseEntity<?> getIngredients() {
//        log.info("getIngredients call :: ");
//        IngredientDto ingredientDto = ingredientService.getIngredients();
//        if (ingredientDto != null) {
//            return new ResponseEntity<>(ingredientDto, HttpStatus.OK);
//        } else {
//            return new ResponseEntity<>("fail", HttpStatus.OK);
//        }
//    }
//
//    @PostMapping
//    @Operation(summary = "", description = "")
//    public ResponseEntity<?> getIngredientsByCat(CategoryVO categoryVO) {
//        log.info("getIngredients call :: ");
//        int n = ingredientService.getIngredients(categoryVO);
//        if (n == 1) {
//            return new ResponseEntity<>()
//        } else {
//            return new ResponseEntity<>()
//        }
//    }
//
//    @PostMapping
//    @Operation(summary = "", description = "")
//    public ResponseEntity<?> getIngredientsByCatAndSubCat(CategoryVO categoryVO) {
//        log.info("getIngredients call :: ");
//        int n = ingredientService.getIngredients(categoryVO);
//        if (n == 1) {
//            return new ResponseEntity<>()
//        } else {
//            return new ResponseEntity<>()
//        }
//    }
//
//
//    @PostMapping("/detail")
//    @Operation(summary = "", description = "")
//    public ResponseEntity<?> getIngredient(IngredientVO ingredientVO) {
//        log.info("getIngredient call :: ");
//        int n = ingredientService.getIngredient(ingredientVO);
//        if (n == 1) {
//            return new ResponseEntity<>();
//        } else {
//            return new ResponseEntity<>();
//        }
//    }
//
//    @PostMapping("/selected")
//    @Operation(summary = "", description = "")
//    public ResponseEntity<?> selectIngredient(UserIngrVO userIngrVO) {
//        log.info("selectIngredient call :: ");
//        int n = ingredientService.selectIngredient(userIngrVO);
//        if (n == 1) {
//            return new ResponseEntity<>();
//        } else {
//            return new ResponseEntity<>();
//        }
//    }
//
//    @PostMapping("/dislike")
//    @Operation(summary = "", description = "")
//    public ResponseEntity<?> dislikeIngredient(IngredientVO ingredientVO) {
//        log.info("dislikeIngredient call :: ");
//        int n = ingredientService.dislikeIngredient(ingredientVO);
//        if (n == 1) {
//            return new ResponseEntity<>();
//        } else {
//            return new ResponseEntity<>();
//        }
//    }
//
//    @PostMapping("/favorite")
//    @Operation(summary = "", description = "")
//    public ResponseEntity<?> favoriteIngredient(UserIngrVO userIngrVO) {
//        log.info("favoriteIngredient call :: ");
//        int n = ingredientService.favoriteIngredient(userIngrVO);
//        if (n == 1) {
//            return new ResponseEntity<>();
//        } else {
//            return new ResponseEntity<>();
//        }
//    }
}
