package com.tls.ingredient.controller;

import com.tls.ingredient.dto.IngredientDto;
import com.tls.ingredient.service.IngredientService;
import com.tls.ingredient.vo.IngredientVO;
import com.tls.jwt.JwtTokenProvider;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
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
import org.springframework.web.bind.annotation.RequestParam;
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

    @GetMapping("category")
    @Operation(summary = "대분류 ID와 중분류 ID로 소분류를 조회하는 메서드",
        description = "대분류 ID와 중분류 ID로 해당하는 소분류를 조회합니다.", tags = "소분류 API")
    public ResponseEntity<?> getIngredientsByCatAndSubCat(@RequestHeader(value = "Authorization", required = false) String tokenWithPrefix,
        @RequestParam int catId, @RequestParam(required = false) String subCatId) {
        log.info("getIngredients call :: ");
        try {
            List<IngredientDto> ingredientDtoList;
            if (tokenWithPrefix.split(" ")[0].equals("Bearer")) {
                String userEmail = jwtTokenProvider.getAuthentication(tokenWithPrefix.substring(7))
                    .getName();
                ingredientDtoList = ingredientService.getIngredients(catId,
                    subCatId == null ? 0 : Integer.parseInt(subCatId), userEmail);
            } else {
                ingredientDtoList = ingredientService.getIngredients(catId,  subCatId == null ? 0 : Integer.parseInt(subCatId), null);
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

    @GetMapping("/detail/{ingrId}")
    @Operation(summary = "소분류를 조회하는 메서드", description = "소분류 ID로 해당 소분류를 조회합니다.", tags = "소분류 API")
    public ResponseEntity<?> getIngredient(
        @RequestHeader(value = "Authorization", required = false) String tokenWithPrefix,
        @PathVariable(name = "ingrId") int ingrId) {
        log.info("getIngredient call :: {}", ingrId);
        try {
            IngredientDto ingredientDto;
            if (tokenWithPrefix.split(" ")[0].equals("Bearer")) {
                String userEmail = jwtTokenProvider.getAuthentication(tokenWithPrefix.substring(7))
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

    @GetMapping("/best")
    @Operation(summary = "오늘의 최저가 소분류 조회하는 메서드", description = "오늘의 최저가 소분류를 조회합니다", tags = "소분류 API")
    public ResponseEntity<?> getBestIngredients() {
        log.info("getTodaysBestIngredients call :: ");
        List<IngredientDto> ingredientDtoList = ingredientService.getBestIngredients();
        if (ingredientDtoList != null) {
            return new ResponseEntity<>(ingredientDtoList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
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
            return new ResponseEntity<>("unauthorization", HttpStatus.OK);
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
