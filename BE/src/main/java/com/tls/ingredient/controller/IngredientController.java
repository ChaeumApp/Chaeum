package com.tls.ingredient.controller;

import com.tls.ingredient.dto.IngredientDto;
import com.tls.ingredient.dto.IngredientPriceDropDto;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.ingredient.service.IngredientService;
import com.tls.ingredient.vo.IngredientVO;
import com.tls.jwt.JwtTokenProvider;
import com.tls.recipe.entity.single.Recipe;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Tag(name = "소분류 API", description = "소분류 관련 API 입니다.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/ingr")
public class IngredientController {

    private final JwtTokenProvider jwtTokenProvider;
    private final IngredientService ingredientService;

    @GetMapping
    @Operation(summary = "전체 소분류를 조회하는 메서드", description = "저장된 전체 소분류를 조회합니다.", tags = "소분류 API")
    public ResponseEntity<?> getIngredients(
        @RequestHeader(value = "Authorization", required = false) String tokenWithPrefix) {
        log.info("getIngredients call :: ");
        try {
            List<IngredientDto> ingredientDtoList;
            if (tokenWithPrefix.split(" ")[0].equals("Bearer")) {
                String userEmail = jwtTokenProvider.getAuthentication(tokenWithPrefix.substring(7))
                    .getName();
                ingredientDtoList = ingredientService.getIngredients(userEmail);
            } else {
                ingredientDtoList = ingredientService.getIngredients(null);
            }
            if (ingredientDtoList != null) {
                return new ResponseEntity<>(ingredientDtoList, HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }

    }

    @GetMapping("category/{catId}/{subCatId}")
    @Operation(summary = "대분류 ID와 중분류 ID로 소분류를 조회하는 메서드",
        description = "대분류 ID와 중분류 ID로 해당하는 소분류를 조회합니다.", tags = "소분류 API")
    public ResponseEntity<?> getIngredientsByCatAndSubCat(
        @RequestHeader(value = "Authorization", required = false) String tokenWithPrefix,
        @PathVariable int catId, @PathVariable(required = false) String subCatId) {
        log.info("getIngredients call :: {} / {}", catId, subCatId);
        try {
            List<List<IngredientDto>> ingredientDtoList = new ArrayList<>();
            int subCatIdInteger = subCatId == null ? 0 : Integer.parseInt(subCatId);
            if (tokenWithPrefix != null && tokenWithPrefix.split(" ")[0].equals("Bearer")) {
                String userEmail = jwtTokenProvider.getAuthentication(tokenWithPrefix.substring(7))
                    .getName();
                ingredientDtoList.add(ingredientService.getIngredients(catId, subCatIdInteger, userEmail)); // 가나다 순서
                ingredientDtoList.add(ingredientService.getIngredientsOrderByScore(catId, subCatIdInteger, userEmail)); // 추천 순서
            } else {
                ingredientDtoList.add(
                    ingredientService.getIngredients(catId, subCatIdInteger, null));
                ingredientDtoList.add(
                    ingredientService.getIngredientsOrderByScore(catId, subCatIdInteger, null));
            }
            return new ResponseEntity<>(ingredientDtoList, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/detail/{ingrId}")
    @Operation(summary = "소분류를 조회하는 메서드", description = "소분류 ID로 해당 소분류를 조회합니다.", tags = "소분류 API")
    public ResponseEntity<?> getIngredient(
        @RequestHeader(value = "Authorization", required = false) String tokenWithPrefix,
        @PathVariable(name = "ingrId") int ingrId) {
        log.info("getIngredient call :: {}", ingrId);
        try {
            IngredientDto ingredientDto;
            if (tokenWithPrefix != null && tokenWithPrefix.split(" ")[0].equals("Bearer")) {
                String userEmail = jwtTokenProvider
                    .getAuthentication(tokenWithPrefix.substring(7))
                    .getName();
                ingredientDto = ingredientService.getIngredient(userEmail, ingrId);
            } else {
                ingredientDto = ingredientService.getIngredient(null, ingrId);
            }
            if (ingredientDto != null) {
                return new ResponseEntity<>(ingredientDto, HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("price/{ingrId}")
    @Operation(summary = "소분류 가격정보를 조회하는 메서드", description = "소분류의 기간에 따른 가격 정보 리스트를 반환합니다.", tags = "소분류 API")
    public ResponseEntity<?> getPriceList(@PathVariable(name = "ingrId") int ingrId) {
        log.info("getPriceList call :: {}", ingrId);
        try {
            return new ResponseEntity<>(ingredientService.getPriceList(ingrId), HttpStatus.OK);
        } catch (Exception e) {
            return getResponseEntity(-1);
        }
    }

    @GetMapping("/best")
    @Operation(summary = "오늘의 최저가 소분류 조회하는 메서드", description = "오늘의 최저가 소분류를 조회합니다", tags = "소분류 API")
    public ResponseEntity<?> getBestIngredients() {
        log.info("getTodaysBestIngredients call :: ");
        List<IngredientPriceDropDto> ingredientList = ingredientService.getBestIngredients();
        if (ingredientList != null) {
            return new ResponseEntity<>(ingredientList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/ateez")
    @Operation(summary = "사용자 추천 점수 상위 10개 소분류 조회하는 메서드", description = "사용자 추천 점수 상위 10개 소분류를 조회합니다", tags = "소분류 API")
    public ResponseEntity<?> getAteezIngredients(@RequestHeader(value = "Authorization", required = false) String tokenWithPrefix) {
        log.info("getAteezIngredients call :: ");
        if (tokenWithPrefix != null && tokenWithPrefix.split(" ")[0].equals("Bearer")) {
            String userEmail = jwtTokenProvider
                .getAuthentication(tokenWithPrefix.substring(7))
                .getName();
            List<Ingredient> ingredientList = ingredientService.getAteezIngredients(userEmail);
            if (ingredientList != null) {
                return new ResponseEntity<>(ingredientList, HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } else {
            return new ResponseEntity<>("unauthorized", HttpStatus.OK);
        }
    }

    @PostMapping("/selected")
    @Operation(summary = "소분류 선택 반영 메서드", description = "사용자가 특정 소분류를 선택한 내용을 저장합니다.", tags = "소분류 API")
    public ResponseEntity<?> selectIngredient(
        @RequestHeader("Authorization") String tokenWithPrefix,
        @RequestBody IngredientVO ingredientVO) {
        try {
            String userEmail = jwtTokenProvider.getAuthentication(tokenWithPrefix.substring(7))
                .getName();
            log.info("selectIngredient call :: {} : {}", userEmail, ingredientVO.getIngrId());
            int n = ingredientService.selectIngredient(userEmail, ingredientVO);
            if (n == 1) {
                return new ResponseEntity<>("success", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>("unauthorized", HttpStatus.OK);
        }

    }

    @PostMapping("/dislike")
    @Operation(summary = "소분류 관심없음 반영 메서드", description = "사용자가 특정 소분류를 관심없음 설정한 내용을 저장합니다.", tags = "소분류 API")
    public ResponseEntity<?> dislikeIngredient(
        @RequestHeader("Authorization") String tokenWithPrefix,
        @RequestBody IngredientVO ingredientVO) {
        try {
            Authentication authentication = jwtTokenProvider
                .getAuthentication(tokenWithPrefix.substring(7));
            log.info("dislikeIngredient call :: {} : {}", authentication.getName(),
                ingredientVO.getIngrId());
            int n = ingredientService.dislikeIngredient(authentication.getName(), ingredientVO);
            if (n == 1) {
                return new ResponseEntity<>("success", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } catch (Exception e) {
            return getResponseEntity(0);
        }
    }

    @PostMapping("/favorite")
    @Operation(summary = "소분류 좋아요 반영 메서드", description = "사용자가 특정 식재료를 좋아요 설정한 내용을 저장합니다.", tags = "소분류 API")
    public ResponseEntity<?> favoriteIngredient(@RequestBody IngredientVO ingredientVO,
        @RequestHeader("Authorization") String tokenWithPrefix) {
        log.info("favoriteIngredient call :: ");
        try {
            Authentication authentication = jwtTokenProvider.getAuthentication(
                tokenWithPrefix.substring(7));
            int n = ingredientService.favoriteIngredient(authentication.getName(),
                ingredientVO.getIngrId());
            return getResponseEntity(n);
        } catch (Exception e) {
            return getResponseEntity(0);
        }
    }

    @GetMapping("/{ingrId}/recipe")
    @Operation(summary = "소분류 관련 레시피 반환 메서드", description = "소분류 id 를 주면 관련 레시피 리시트를 반환한다.", tags = "소분류 API")
    public ResponseEntity<?> getRelatedRecipeList(@PathVariable(name = "ingrId") int ingrId) {
        List<Recipe> results = ingredientService.getRelatedRecipeList(ingrId);
        if (results == null) {
            return getResponseEntity(-1);
        }
        return new ResponseEntity<>(results, HttpStatus.OK);
    }

    private ResponseEntity<?> getResponseEntity(int resultCode) {
        if (resultCode == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else if (resultCode == 0) {
            return new ResponseEntity<>("unauthorized", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }
}
