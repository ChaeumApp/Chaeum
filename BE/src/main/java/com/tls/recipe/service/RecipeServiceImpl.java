package com.tls.recipe.service;

import com.tls.config.ReadExcel;
import com.tls.recipe.entity.composite.UserRecipe;
import com.tls.recipe.entity.composite.UserRecipeLog;
import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.repository.RecipeRepository;
import com.tls.recipe.repository.UserRecipeLogRepository;
import com.tls.recipe.repository.UserRecipeRepository;
import com.tls.user.repository.UserRepository;
import com.tls.user.entity.User;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class RecipeServiceImpl implements RecipeService {

    private final RecipeRepository recipeRepository;
    private final UserRepository userRepository;
    private final UserRecipeLogRepository userRecipeLogRepository;
    private final UserRecipeRepository userRecipeRepository;

    @Override
    public int updateRecipe() {
        try {
            List<String[]> recipes = new ReadExcel().readExcel(
                "D://ssafy//2학기//채움//S09P22C204//RecipeCrawling//", "recipe.xlsx");
            recipeRepository.deleteAllInBatch();
            for (String[] oneRecipe : recipes) {
                Recipe recipe = Recipe.builder()
                    .recipeName(oneRecipe[0])
                    .recipeLink(oneRecipe[4])
                    .recipeThumbnail(oneRecipe[3])
                    .build();
                recipeRepository.save(recipe);
            }
            log.info("{} recipes are updated", recipes.size());
            return 1;
        } catch (Exception e) {
            log.info("error occurred updating recipes");
            return -1;
        }
    }

    @Override
    public Recipe viewRecipe(int recipeId) {
        return recipeRepository.findByRecipeId(recipeId).orElse(null);
    }

    @Override
    public List<Recipe> suggestedRecipes(String userEmail) {
        List<Recipe> tmp = new ArrayList<>();
        tmp.add(new Recipe(0, "recipe name", "recipe link", "recipe thumbnail"));
        return tmp;
    }

    @Override
    public int selectRecipe(String userEmail, int recipeId) {
        try {
            if (recipeRepository.findByRecipeId(recipeId).isEmpty()) { // 만약 레시피 아이디가 존재하지 않으면
                return 0;
            } else { // 아이디가 존재하면
                UserRecipeLog userRecipeLog = UserRecipeLog.builder()
                    .userId(userRepository.findByUserEmail(userEmail).orElseThrow())
                    .recipeId(recipeRepository.findByRecipeId(recipeId).orElseThrow()).build();
                userRecipeLogRepository.save(userRecipeLog);
                return 1;
            }
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public int likeRecipe(String userEmail, int recipeId) {
        try {
            User user = userRepository.findByUserEmail(userEmail).orElseThrow();
            Recipe recipe = recipeRepository.findByRecipeId(recipeId).orElseThrow();
            if (userRecipeRepository.findByUserIdAndRecipeId(user, recipe)
                .isEmpty()) { // 즐겨찾기에 존재한다면
                UserRecipe userRecipe = UserRecipe.builder()
                    .userId(userRepository.findByUserEmail(userEmail).orElseThrow())
                    .recipeId(recipeRepository.findByRecipeId(recipeId).orElseThrow()).build();
                userRecipeRepository.save(userRecipe); // 즐겨찾기 목록에 등록
            } else { // 이미 즐겨찾기 목록에 존재한다면
                userRecipeRepository.deleteByUserIdAndRecipeId(user, recipe);
            }
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public List<Recipe> findByIngrName(String ingrName) {
        return recipeRepository.findByRecipeNameLike(ingrName);
    }
}
