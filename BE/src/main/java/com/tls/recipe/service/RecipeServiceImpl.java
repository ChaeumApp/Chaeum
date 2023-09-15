package com.tls.recipe.service;

import com.tls.recipe.entity.composite.UserRecipe;
import com.tls.recipe.entity.composite.UserRecipeLog;
import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.id.UserRecipeId;
import com.tls.recipe.repository.RecipeRepository;
import com.tls.recipe.repository.UserRecipeLogRepository;
import com.tls.recipe.repository.UserRecipeRepository;
import com.tls.user.repository.UserRepository;
import com.tls.user.entity.User;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RecipeServiceImpl implements RecipeService {

    private final RecipeRepository recipeRepository;
    private final UserRepository userRepository;
    private final UserRecipeLogRepository userRecipeLogRepository;
    private final UserRecipeRepository userRecipeRepository;

    @Override
    public int updateRecipe() {
        return (int) (Math.random() % 2);
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
            if (userRecipeRepository.findByUserIdAndRecipeId(user, recipe).isEmpty()) { // 즐겨찾기에 존재한다면
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
}
