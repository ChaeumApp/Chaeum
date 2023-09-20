package com.tls.recipe.service;

import com.tls.config.ReadExcel;
import com.tls.recipe.dto.RecipeDto;
import com.tls.recipe.entity.composite.RecipeProc;
import com.tls.recipe.entity.composite.UserRecipe;
import com.tls.recipe.entity.composite.UserRecipeLog;
import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.repository.RecipeProcRepository;
import com.tls.recipe.repository.RecipeRepository;
import com.tls.recipe.repository.UserRecipeLogRepository;
import com.tls.recipe.repository.UserRecipeRepository;
import com.tls.user.repository.UserRepository;
import com.tls.user.entity.User;
import java.util.ArrayList;
import java.util.Collections;
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
    private final RecipeProcRepository recipeProcRepository;

    @Override
    public int updateRecipe() {
        try {
            List<String[]> recipes = new ReadExcel().readExcel("recipe.xlsx");
//            recipeRepository.deleteAllInBatch();
            int cnt = 0;
            for (String[] oneRecipe : recipes) {
                Recipe recipe = Recipe.builder()
                    .recipeName(oneRecipe[0])
                    .recipeLink(oneRecipe[4])
                    .recipeThumbnail(oneRecipe[3])
                    .build();
                recipeRepository.save(recipe);
                String recipeProcess = oneRecipe[2].substring(1, oneRecipe[2].length() - 1);
                List<RecipeProc> allLists = new ArrayList<>();
                for (String process : recipeProcess.split("\', \'")) {
                    process = process.replaceAll("'", "");
                    RecipeProc recipeProc = RecipeProc.builder()
                        .recipeId(recipe)
                        .recipeProcId(process.charAt(0) - '0')
                        .recipeProcContent(process.substring(3))
                        .build();
                    allLists.add(recipeProc);
                }
                recipeProcRepository.saveAll(allLists);
                if (++cnt % 100 == 0) {
                    log.info("total ~{} recipes are updated", cnt);
                }
            }
            log.info("{} recipes are updated", recipes.size());
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            log.info("error occurred updating recipes");
            return -1;
        }
    }

    @Override
    public RecipeDto viewRecipe(int recipeId) {
        try{
            List<String> process = new ArrayList<>();
            Recipe recipe = recipeRepository.findByRecipeId(recipeId).orElseThrow();
            recipeProcRepository.findByRecipeId(recipe).forEach(recipeProc -> {
                process.add(recipeProc.getRecipeProcContent());
            });
            return RecipeDto.builder()
                .recipeName(recipe.getRecipeName())
                .recipeThumbnail(recipe.getRecipeThumbnail())
                .recipeLink(recipe.getRecipeLink())
                .recipeProcess(process)
                .recipeIngredients(null)
                .build();
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }

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

    @Override
    public List<Recipe> listAllRecipes() {
        List<Recipe> results = recipeRepository.findAll();
        Collections.shuffle(results);
        return results;
    }
}