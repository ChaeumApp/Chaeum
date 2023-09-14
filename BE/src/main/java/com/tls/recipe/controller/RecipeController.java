package com.tls.recipe.controller;

import com.tls.jwt.JwtTokenProvider;
import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.service.RecipeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@Tag(name = "레시피 API", description = "레시피 관련 API 입니다.")
@RequiredArgsConstructor
@RequestMapping("/recipe")
public class RecipeController {

    private final RecipeService recipeService;
    private final JwtTokenProvider jwtTokenProvider;

    @GetMapping("/update")
    @Operation(summary = "레시피를 업데이트 하는 메서드", description = "해당 url 을 요청하면 DB에 recipe 를 업데이트합니다.", tags = "레시피 API")
    public ResponseEntity<?> updateRecipe() {
        log.info("updateRecipe call :: ");
        int n = recipeService.updateRecipe();
        if (n == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/detail/{recipeId}")
    @Operation(summary = "레시피 상세 조회 메서드", description = "레시피 번호에 대한 상세 조회")
    @ApiResponse(responseCode = "200", description = "레시피 상세 조회 시 해당 레시피 정보를 반환한다.\n"
        + "해당 레시피 번호가 없을 경우 fail 을 반환한다.")
    public ResponseEntity<?> viewRecipe(@PathVariable("recipeId") int recipeId) {
        Recipe recipe = recipeService.viewRecipe(recipeId);
        if (recipe == null) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        } else {
            return new ResponseEntity<>(recipe, HttpStatus.OK);
        }
    }

}
