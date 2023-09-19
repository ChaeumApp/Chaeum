package com.tls.recipe.controller;

import com.tls.jwt.JwtTokenProvider;
import com.tls.recipe.dto.RecipeDto;
import com.tls.recipe.service.RecipeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
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

    @GetMapping("/suggestion")
    @Operation(summary = "사용자 맞춤형 레시피 추천 메서드", description = "유저 정보에 맞는 추천 레시피 List를 반환한다.", tags = "레시피 API")
    @ApiResponse(responseCode = "200", description = "레피시 추천 리스트 반환한다.\n"
        + "추천 레시피 리스트 반환 실패 시 fail 을 반환한다.\n")
    public ResponseEntity<?> suggestedRecipes(@RequestHeader String tokenWithPrefix) {
        try {
            String userEmail = jwtTokenProvider.getAuthentication(tokenWithPrefix.substring(7))
                .getName();
            return new ResponseEntity<>(recipeService.suggestedRecipes(userEmail), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/detail/{recipeId}")
    @Operation(summary = "레시피 상세 조회 메서드", description = "레시피 번호에 대한 상세 조회", tags = "레시피 API")
    @ApiResponse(responseCode = "200", description = "레시피 상세 조회 시 해당 레시피 정보를 반환한다.\n"
        + "해당 레시피 번호가 없을 경우 fail 을 반환한다.")
    public ResponseEntity<?> viewRecipe(@PathVariable("recipeId") int recipeId) {
        log.info("{} recipe detail view", recipeId);
        RecipeDto recipe = recipeService.viewRecipe(recipeId);
        return new ResponseEntity<>(recipe, HttpStatus.OK);
    }

    @GetMapping("/selected/{recipeId}")
    @Operation(summary = "레시피 선택 로그 기록 메서드", description = "레시피 클릭 시 레시피 아이디를 주면 로그를 기록한다.", tags = "레시피 API")
    @ApiResponse(responseCode = "200", description = "레시피 로그 등록 성공 시 success 를 반환한다.\n"
        + "레시피 로그 등록 실패 시 fail 을 반환한다.\n"
        + "없는 레시피를 클릭했다고 요청이 온다면 unauthorized 를 반환한다.")
    public ResponseEntity<?> selectRecipe(@PathVariable("recipeId") int recipeId,
        @RequestHeader("Authorization") String tokenWithPrefix) {
        try {
            String userEmail = jwtTokenProvider.getAuthentication(tokenWithPrefix.substring(7))
                .getName();
            int resultCode = recipeService.selectRecipe(userEmail, recipeId);
            if (resultCode == 1) {
                return new ResponseEntity<>("success", HttpStatus.OK);
            } else if (resultCode == 0) {
                return new ResponseEntity<>("unauthorized", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/favorite/{recipeId}")
    @Operation(summary = "레시피 즐겨찾기/즐찾해제 메서드", description = "즐겨찾기가 되어있지 않은 레시피의 경우 즐겨찾기를 하고, 즐겨찾기가 되어있는 레시피의 경우 즐겨찾기를 해제한다.", tags = "레시피 API")
    @ApiResponse(responseCode = "200", description = "즐겨찾기 등록 성공 시 success 를 반환한다.\n"
        + "즐겨찾기 등록 실패 시 fail 을 반환한다.\n"
        + "없는 레시피를 클릭했다고 요청이 온다면 unauthorized 를 반환한다.")
    public ResponseEntity<?> likeRecipe(@PathVariable("recipeId") int recipeId,
        @RequestHeader("Authorization") String tokenWithPrefix) {
        try {
            String userEmail = jwtTokenProvider.getAuthentication(tokenWithPrefix.substring(7))
                .getName();
            int resultCode = recipeService.likeRecipe(userEmail, recipeId);
            if (resultCode == 1) {
                return new ResponseEntity<>("success", HttpStatus.OK);
            } else if (resultCode == 0) {
                return new ResponseEntity<>("unauthorized", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/{ingrName}")
    @Operation(summary = "소분류 관련 레시피 검색 메서드", description = "소분류 이름을 주면 이름이 포함된 레시피 배열을 반환한다.", tags = "레시피 API")
    public ResponseEntity<?> findByIngrName(@PathVariable("ingrName") String ingrName) {
        return new ResponseEntity<>(recipeService.findByIngrName(ingrName), HttpStatus.OK);
    }

    @GetMapping
    @Operation(summary = "레시피 전체 조회 메서드", description = "전체 레시피 리스트를 반환한다.", tags = "레시피 API")
    public ResponseEntity<?> listAllRecipes() {
        return new ResponseEntity<>(recipeService.listAllRecipes(), HttpStatus.OK);
    }
}
