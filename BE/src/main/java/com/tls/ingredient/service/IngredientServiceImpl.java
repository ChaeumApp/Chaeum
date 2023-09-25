package com.tls.ingredient.service;

import com.tls.ingredient.IngredientPriceVO;
import com.tls.ingredient.dto.IngredientDto;
import com.tls.ingredient.entity.composite.IngredientRecommend;
import com.tls.ingredient.entity.composite.UserIngr;
import com.tls.ingredient.entity.composite.UserIngrLog;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.ingredient.entity.single.IngredientPrice;
import com.tls.ingredient.repository.IngrRepository;
import com.tls.ingredient.converter.IngredientConverter;
import com.tls.ingredient.repository.IngredientPriceRepository;
import com.tls.ingredient.repository.IngredientRecommendRepository;
import com.tls.ingredient.repository.UserIngrLogRepository;
import com.tls.ingredient.repository.UserIngrRepository;
import com.tls.ingredient.vo.IngredientVO;
import com.tls.category.repository.CategoryRepository;
import com.tls.category.repository.SubCategoryRepository;
import com.tls.user.entity.User;
import com.tls.user.repository.UserRepository;
import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class IngredientServiceImpl implements IngredientService {

    private final UserRepository userRepository;
    private final IngrRepository ingrRepository;
    private final UserIngrRepository userIngrRepository;
    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;
    private final UserIngrLogRepository userIngrLogRepository;
    private final IngredientConverter ingredientConverter;
    private final IngredientRecommendRepository ingredientRecommendRepository;
    private final IngredientPriceRepository ingredientPriceRepository;
    private final int TERM = 7;
    private final int NUMBERS = 10;

    @Override
    public List<IngredientDto> getIngredients(String userEmail) {
        List<IngredientDto> results = new ArrayList<>();
        try {
            if(userEmail != null){
                ingrRepository.findAll().orElseThrow().forEach(ingredient ->
                    results.add(ingredientConverter.entityToDto(userEmail, ingredient))
                );
            } else{
                ingrRepository.findAll().orElseThrow().forEach(ingredient ->
                    results.add(ingredientConverter.entityToDto(ingredient)));
            }
        } catch (Exception e) {
            return null;
        }
        return results;
    }

    @Override
    public List<IngredientDto> getIngredients(int catId, int subCatId, String userEmail) {
        List<IngredientDto> results = new ArrayList<>();
        try {
            if (subCatId == 0) {
                if(userEmail != null){
                    Objects.requireNonNull(ingrRepository.findByCategory(
                            categoryRepository.findByCatId(catId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(ingredientConverter.entityToDto(userEmail, ingredient)));
                } else {
                    Objects.requireNonNull(ingrRepository.findByCategory(
                            categoryRepository.findByCatId(catId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(ingredientConverter.entityToDto(ingredient)));
                }
            } else {
                if(userEmail != null){
                    Objects.requireNonNull(ingrRepository.findByCategoryAndSubCategory(
                            categoryRepository.findByCatId(catId).orElseThrow(),
                            subCategoryRepository.findBySubCatId(subCatId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(ingredientConverter.entityToDto(userEmail, ingredient)));
                } else {
                    Objects.requireNonNull(ingrRepository.findByCategoryAndSubCategory(
                            categoryRepository.findByCatId(catId).orElseThrow(),
                            subCategoryRepository.findBySubCatId(subCatId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(ingredientConverter.entityToDto(ingredient)));
                }
            }
            return results;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<IngredientDto> getIngredientsOrderByScore(int catId, int subCatId, String userEmail) {
        List<IngredientDto> results = new ArrayList<>();
        try {
            if (subCatId == 0) {
                if(userEmail != null){
                    User user = userRepository.findByUserEmail(userEmail).orElseThrow();
                    List<IngredientRecommend> recommendedIngredients =
                        ingredientRecommendRepository.findByUserOrderByIngrRecommendScoreDesc(user);
                    for (IngredientRecommend recommend : recommendedIngredients) {
                        Ingredient ingredient = recommend.getIngredient();
                        if(ingredient.getCategory().getCatId() != catId) continue;
                        results.add(ingredientConverter.entityToDto(userEmail, ingredient));
                    }
                } else {
                    Objects.requireNonNull(ingrRepository.findByCategory(
                            categoryRepository.findByCatId(catId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(ingredientConverter.entityToDto(ingredient)));
                    Collections.shuffle(results);
                }
            } else {
                if(userEmail != null){
                    User user = userRepository.findByUserEmail(userEmail).orElseThrow();
                    List<IngredientRecommend> recommendedIngredients =
                        ingredientRecommendRepository.findByUserOrderByIngrRecommendScoreDesc(user);
                    for (IngredientRecommend recommend : recommendedIngredients) {
                        Ingredient ingredient = recommend.getIngredient();
                        if(ingredient.getCategory().getCatId() != catId) continue;
                        if(ingredient.getSubCategory().getSubCatId() != subCatId) continue;
                        results.add(ingredientConverter.entityToDto(userEmail, ingredient));
                    }
                } else {
                    Objects.requireNonNull(ingrRepository.findByCategoryAndSubCategory(
                            categoryRepository.findByCatId(catId).orElseThrow(),
                            subCategoryRepository.findBySubCatId(subCatId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(ingredientConverter.entityToDto(ingredient)));
                    Collections.shuffle(results);
                }
            }
            return results;
        } catch (Exception e) {
            return null;
        }
    }

    public List<IngredientDto> getBestIngredients() {
        return null;
    }

    @Override
    public IngredientDto getIngredient(String userEmail, int ingrId) {
        try {
            if (userEmail != null) {
                return ingredientConverter.entityToDto(userEmail,
                    ingrRepository.findByIngrId(ingrId).orElseThrow());
            } else {
                return ingredientConverter.entityToDto(
                    ingrRepository.findByIngrId(ingrId).orElseThrow());
            }
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public int selectIngredient(String userEmail, IngredientVO ingredientVO) {
        try {
            UserIngrLog userIngrLog = UserIngrLog.builder()
                .userId(userRepository.findByUserEmail(userEmail).orElseThrow())
                .ingrId(ingrRepository.findByIngrId(ingredientVO.getIngrId()).orElseThrow())
                .build();
            userIngrLogRepository.save(userIngrLog);
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public int dislikeIngredient(IngredientVO ingredientVO) {
        return 0;
    }

    @Override
    @Transactional
    public int favoriteIngredient(String userEmail, int ingrId) {
        try {
            User user = userRepository.findByUserEmail(userEmail).orElse(null);
            Ingredient ingredient = ingrRepository.findByIngrId(ingrId).orElse(null);
            if (userIngrRepository.findByUserIdAndIngrId(user, ingredient).isPresent()) {
                userIngrRepository.deleteByUserIdAndIngrId(user, ingredient);
            } else {
                userIngrRepository.save(
                    UserIngr.builder()
                        .userId(user)
                        .ingrId(ingredient)
                        .build()
                );
            }
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public List<IngredientPriceVO> getPriceList(int ingrId) {
        try{
            List<IngredientPriceVO> ingredientPriceVOs = new ArrayList<>();
            Ingredient ingredient = ingrRepository.findByIngrId(ingrId).orElseThrow();
            List<IngredientPrice> list = ingredientPriceRepository.findByIngrId(ingredient).orElseThrow();
            for(int i = 0 ; i < list.size(); i++) {
                IngredientPrice ingredientPrice = list.get(i);
                if ((ChronoUnit.DAYS.between(ingredientPrice.getDate(), LocalDate.now())) % TERM != 0){
                    continue;
                }
                IngredientPriceVO ingredientPriceVO = IngredientPriceVO.builder()
                    .price(ingredientPrice.getPrice())
                    .date(ingredientPrice.getDate())
                    .build();
                ingredientPriceVOs.add(ingredientPriceVO);
                if( i+1 == NUMBERS) break;
            }
            return ingredientPriceVOs;
        } catch (Exception e){
            return null;
        }

    }
}
