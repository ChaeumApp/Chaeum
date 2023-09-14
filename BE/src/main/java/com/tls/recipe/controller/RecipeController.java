package com.tls.recipe.controller;

import com.tls.recipe.service.RecipeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@Tag(name="레시피 API", description = "레시피 관련 API 입니다.")
@RequiredArgsConstructor
@RequestMapping("/recipe")
public class RecipeController {

    private final RecipeService recipeService;

    @GetMapping("/update")
    @Operation(summary = "레시피를 업데이트 하는 메서드", description = "해당 url 을 요청하면 DB에 recipe 를 업데이트합니다.", tags = "레시피 API")
    public ResponseEntity<?> updateRecipe(){
        log.info("updateRecipe call :: ");
        int n = recipeService.updateRecipe();
        if( n == 1 ){
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }
}
