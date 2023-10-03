package com.tls.ingredient.service;

import com.tls.config.HttpConnectionConfig;
import com.tls.ingredient.IngredientPriceVO;
import com.tls.ingredient.converter.IngredientConverter;
import com.tls.ingredient.dto.IngredientDto;
import com.tls.ingredient.entity.composite.IngredientPreference;
import com.tls.ingredient.entity.composite.IngredientRecommend;
import com.tls.ingredient.entity.composite.UserIngr;
import com.tls.ingredient.entity.composite.UserIngrLog;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.ingredient.entity.single.IngredientPrice;
import com.tls.ingredient.repository.IngredientRepository;
import com.tls.ingredient.repository.IngredientPreferenceRepository;
import com.tls.ingredient.repository.IngredientPriceRepository;
import com.tls.ingredient.repository.IngredientRecommendRepository;
import com.tls.ingredient.repository.UserIngrLogRepository;
import com.tls.ingredient.repository.UserIngrRepository;
import com.tls.ingredient.vo.IngredientVO;
import com.tls.category.repository.CategoryRepository;
import com.tls.category.repository.SubCategoryRepository;
import com.tls.recipe.dto.RecipeDto;
import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.repository.RecipeIngredientRepository;
import com.tls.recipe.repository.RecipeProcRepository;
import com.tls.recipe.repository.RecipeRepository;
import com.tls.user.entity.User;
import com.tls.user.repository.UserRepository;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class IngredientServiceImpl implements IngredientService {

    private final UserRepository userRepository;
    private final IngredientRepository ingredientRepository;
    private final UserIngrRepository userIngrRepository;
    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;
    private final UserIngrLogRepository userIngrLogRepository;
    private final IngredientConverter ingredientConverter;
    private final IngredientRecommendRepository ingredientRecommendRepository;
    private final IngredientPriceRepository ingredientPriceRepository;
    private final RecipeRepository recipeRepository;
    private final RecipeIngredientRepository recipeIngredientRepository;
    private final RecipeProcRepository recipeProcRepository;
    private final IngredientPreferenceRepository ingredientPreferenceRepository;

    private final int TERM = 7;
    private final int NUMBERS = 12;

    @Override
    public List<IngredientDto> getIngredients(String userEmail) {
        List<IngredientDto> results = new ArrayList<>();
        try {
            if (userEmail != null) {
                ingredientRepository.findAll().orElseThrow().forEach(ingredient ->
                    results.add(ingredientConverter.entityToDto(userEmail, ingredient))
                );
            } else {
                ingredientRepository.findAll().orElseThrow().forEach(ingredient ->
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
                if (userEmail != null) {
                    Objects.requireNonNull(ingredientRepository.findByCategory(
                            categoryRepository.findByCatId(catId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(
                                ingredientConverter.entityToDto(userEmail, ingredient)));
                } else {
                    Objects.requireNonNull(ingredientRepository.findByCategory(
                            categoryRepository.findByCatId(catId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(ingredientConverter.entityToDto(ingredient)));
                }
            } else {
                if (userEmail != null) {
                    Objects.requireNonNull(ingredientRepository.findByCategoryAndSubCategory(
                            categoryRepository.findByCatId(catId).orElseThrow(),
                            subCategoryRepository.findBySubCatId(subCatId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(
                                ingredientConverter.entityToDto(userEmail, ingredient)));
                } else {
                    Objects.requireNonNull(ingredientRepository.findByCategoryAndSubCategory(
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
    public List<IngredientDto> getIngredientsOrderByScore(int catId, int subCatId,
        String userEmail) {
        List<IngredientDto> results = new ArrayList<>();
        try {
            if (subCatId == 0) {
                if (userEmail != null) {
                    User user = userRepository.findByUserEmail(userEmail).orElseThrow();
                    List<IngredientRecommend> recommendedIngredients =
                        ingredientRecommendRepository.findByUserOrderByIngrRecommendScoreDesc(user);
                    for (IngredientRecommend recommend : recommendedIngredients) {
                        Ingredient ingredient = recommend.getIngredient();
                        if (ingredient.getCategory().getCatId() != catId) {
                            continue;
                        }
                        results.add(ingredientConverter.entityToDto(userEmail, ingredient));
                    }
                } else {
                    Objects.requireNonNull(ingredientRepository.findByCategory(
                            categoryRepository.findByCatId(catId).orElseThrow()).orElse(null))
                        .forEach(
                            ingredient -> results.add(ingredientConverter.entityToDto(ingredient)));
                    Collections.shuffle(results);
                }
            } else {
                if (userEmail != null) {
                    User user = userRepository.findByUserEmail(userEmail).orElseThrow();
                    List<IngredientRecommend> recommendedIngredients =
                        ingredientRecommendRepository.findByUserOrderByIngrRecommendScoreDesc(user);
                    for (IngredientRecommend recommend : recommendedIngredients) {
                        Ingredient ingredient = recommend.getIngredient();
                        if (ingredient.getCategory().getCatId() != catId) {
                            continue;
                        }
                        if (ingredient.getSubCategory().getSubCatId() != subCatId) {
                            continue;
                        }
                        results.add(ingredientConverter.entityToDto(userEmail, ingredient));
                    }
                } else {
                    Objects.requireNonNull(ingredientRepository.findByCategoryAndSubCategory(
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

    @Override
    public List<Ingredient> getBestIngredients() {
        try {
            LocalDate today = LocalDate.now();
            LocalDate yesterday = today.minusDays(1);

            Pageable pageable = PageRequest.of(0, 10);
            return ingredientPriceRepository.findTop10PriceDrops(today, yesterday, pageable);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public IngredientDto getIngredient(String userEmail, int ingrId) {
        try {
            if (userEmail != null) {
                return ingredientConverter.entityToDto(userEmail,
                    ingredientRepository.findByIngrId(ingrId).orElseThrow());
            } else {
                return ingredientConverter.entityToDto(
                    ingredientRepository.findByIngrId(ingrId).orElseThrow());
            }
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    @Transactional
    public int selectIngredient(String userEmail, IngredientVO ingredientVO) { // 소분류 클릭
        try {
            User user = userRepository.findByUserEmail(userEmail).orElseThrow();
            Ingredient ingredient = ingredientRepository.findByIngrId(ingredientVO.getIngrId())
                .orElseThrow();
            UserIngrLog userIngrLog = UserIngrLog.builder()
                .userId(user)
                .ingrId(ingredient)
                .build();
            userIngrLogRepository.save(userIngrLog);

            IngredientPreference ingredientPreference = ingredientPreferenceRepository
                .findByUserAndIngredient(user, ingredient).orElseThrow();
            ingredientPreference.updatePrefRating(ingredientPreference.getPrefRating() + 10);

            HttpConnectionConfig.callDjangoConn(user.getUserId()); // 장고에게 업데이트 되었다고 알려준다.

            return 1;
        } catch (NoSuchElementException e) { // 선호도 점수가 없을 경우 새로 만든다.
            User user = userRepository.findByUserEmail(userEmail).orElseThrow();
            Ingredient ingredient = ingredientRepository.findByIngrId(ingredientVO.getIngrId())
                .orElseThrow();
            IngredientPreference ingredientPreference = IngredientPreference.builder()
                .prefRating(10)
                .ingredient(ingredient)
                .user(user)
                .build();
            ingredientPreferenceRepository.save(ingredientPreference);
            HttpConnectionConfig.callDjangoConn(user.getUserId()); // 장고에게 업데이트 되었다고 알려준다.
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    @Override
    @Transactional
    public int dislikeIngredient(String userEmail, IngredientVO ingredientVO) { // 소분류 관심없음
        try {
            User user = userRepository.findByUserEmail(userEmail).orElseThrow();

            Ingredient ingredient = ingredientRepository.findByIngrId(ingredientVO.getIngrId())
                .orElseThrow();
            UserIngrLog userIngrLog = UserIngrLog.builder()
                .userId(user)
                .ingrId(ingredient)
                .build();
            userIngrLogRepository.save(userIngrLog);

            IngredientPreference ingredientPreference = ingredientPreferenceRepository
                .findByUserAndIngredient(user, ingredient).orElseThrow();
            ingredientPreference.updatePrefRating(ingredientPreference.getPrefRating() - 150);
            HttpConnectionConfig.callDjangoConn(user.getUserId()); // 장고에게 업데이트 되었다고 알려준다.
            return 1;
        } catch (NoSuchElementException e) { // 선호도 점수가 없을 경우 새로 만든다.
            User user = userRepository.findByUserEmail(userEmail).orElseThrow();
            Ingredient ingredient = ingredientRepository.findByIngrId(ingredientVO.getIngrId())
                .orElseThrow();
            IngredientPreference ingredientPreference = IngredientPreference.builder()
                .prefRating(-150)
                .ingredient(ingredient)
                .user(user)
                .build();
            ingredientPreferenceRepository.save(ingredientPreference);
            HttpConnectionConfig.callDjangoConn(user.getUserId()); // 장고에게 업데이트 되었다고 알려준다.
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    @Override
    @Transactional
    public int favoriteIngredient(String userEmail, int ingrId) { // 소분류 좋아요
        boolean tf = false;
        try {
            User user = userRepository.findByUserEmail(userEmail).orElse(null);
            Ingredient ingredient = ingredientRepository.findByIngrId(ingrId).orElse(null);
            if (userIngrRepository.findByUserIdAndIngrId(user, ingredient).isPresent()) {
                userIngrRepository.deleteByUserIdAndIngrId(user, ingredient);
                tf = true;
                IngredientPreference ingredientPreference = ingredientPreferenceRepository
                    .findByUserAndIngredient(user, ingredient).orElseThrow();
                ingredientPreference.updatePrefRating(ingredientPreference.getPrefRating() - 150);
            } else {
                userIngrRepository.save(
                    UserIngr.builder()
                        .userId(user)
                        .ingrId(ingredient)
                        .build()
                );
                IngredientPreference ingredientPreference = ingredientPreferenceRepository
                    .findByUserAndIngredient(user, ingredient).orElseThrow();
                ingredientPreference.updatePrefRating(ingredientPreference.getPrefRating() + 150);
            }
            HttpConnectionConfig.callDjangoConn(user.getUserId()); // 장고에게 업데이트 되었다고 알려준다.
            return 1;
        } catch (NoSuchElementException e) { // 선호도 점수가 없을 경우 새로 만든다.
            int score = 150;
            if(tf)  score *= -1;
            User user = userRepository.findByUserEmail(userEmail).orElseThrow();
            Ingredient ingredient = ingredientRepository.findByIngrId(ingrId)
                .orElseThrow();
            IngredientPreference ingredientPreference = IngredientPreference.builder()
                .prefRating(score)
                .ingredient(ingredient)
                .user(user)
                .build();
            ingredientPreferenceRepository.save(ingredientPreference);
            HttpConnectionConfig.callDjangoConn(user.getUserId()); // 장고에게 업데이트 되었다고 알려준다.
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public List<IngredientPriceVO> getPriceList(int ingrId) {
        try {
            List<IngredientPriceVO> ingredientPriceVOs = new ArrayList<>();
            Ingredient ingredient = ingredientRepository.findByIngrId(ingrId).orElseThrow();
            List<IngredientPrice> list = ingredientPriceRepository.findByIngrIdOrderByDateDesc(ingredient)
                .orElseThrow();
            for (int i = 0; i < list.size(); i++) {
                IngredientPrice ingredientPrice = list.get(i);
                if ((ChronoUnit.DAYS.between(ingredientPrice.getDate(), LocalDate.now())) % TERM
                    != 0) {
                    continue;
                }
                IngredientPriceVO ingredientPriceVO = IngredientPriceVO.builder()
                    .price(ingredientPrice.getPrice())
                    .date(ingredientPrice.getDate())
                    .build();
                ingredientPriceVOs.add(ingredientPriceVO);
                if (i + 1 == NUMBERS) {
                    break;
                }
            }
            return ingredientPriceVOs;
        } catch (Exception e) {
            return null;
        }

    }

    @Override
    public List<Recipe> getRelatedRecipeList(int ingrId) {
        try {
            Ingredient ingredient = ingredientRepository.findByIngrId(ingrId).orElseThrow();
            List<Recipe> results = new ArrayList<>();
            List<Recipe> selectAll = recipeRepository.findAll();
            selectAll.forEach(recipe -> {
                RecipeDto recipeDto = entityToDto(recipe);
                for (String[] recipeIngredient : recipeDto.getRecipeIngredients()) {
                    if (recipeIngredient[0].contains(ingredient.getIngrName())) {
                        results.add(recipe);
                        break;
                    }
                }
            });
            return results;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public RecipeDto entityToDto(Recipe recipe) {
        List<String[]> ingredientList = new ArrayList<>();
        List<String> processList = new ArrayList<>();
        recipeProcRepository.findByRecipeId(recipe).forEach(recipeProc ->
            processList.add(recipeProc.getRecipeProcContent())
        );
        recipeIngredientRepository.findByRecipeId(recipe).forEach(recipeIngr -> {
                ingredientList.add(
                    new String[]{recipeIngr.getRecipeIngrName(), recipeIngr.getRecipeIngrAmount()});
            }
        );
        return RecipeDto.builder()
            .recipeId(recipe.getRecipeId())
            .recipeThumbnail(recipe.getRecipeThumbnail())
            .recipeLink(recipe.getRecipeLink())
            .recipeName(recipe.getRecipeName())
            .recipeIngredients(ingredientList)
            .recipeProcess(processList)
            .build();
    }
}
