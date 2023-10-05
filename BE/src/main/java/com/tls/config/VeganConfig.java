package com.tls.config;

import com.tls.ingredient.repository.IngredientPreferenceRepository;
import com.tls.ingredient.repository.IngredientRepository;
import com.tls.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class VeganConfig {
    private final IngredientPreferenceRepository ingredientPreferenceRepository;
    private final IngredientRepository ingredientRepository;

    private final int[] vegan1 = new int[]{1, 2, 3, 4, 6, 7, 11, 19, 21, 25, 26, 30, 31, 32, 33, 38, 39, 40, 42, 43, 44, 46, 47, 48, 53, 58,59,60,61,63,64,69,70,75,76,77,78,79,80,81,84,85,86,90,92,95,96,97,99,100,101,102,103,104,105,106,107,108,109,110,111,115,118,121,124,134,135,139,140,141, 143,145,148,149,152,153,158,161,162,169,170,171,173,175,179,180,187,194,195,198,203,204,205,210,211,212,213,214,215,216,217,218,219,220,221,222,223,225,226,230,233,238,242,251,256,257,258,262,265,267,268,269,271,274,279,288,289,290,292,293,294,296,297,303,306,308,309,311,314,315,316,317,320,321,323,325,326,327,331,332,339,341,342,347,349,352,356,359,360,361,362,364,369,370,374,375,380,383,386,389,390,392,393,394,399,402,403,405,406,407,408,410,411,412,413,416};
    private final int[] vegan2 = new int[]{1, 2, 3, 4, 6, 7, 11, 19, 21, 25, 26, 30, 31, 32, 33, 38, 39, 40, 42, 43, 44, 46, 47, 48, 53, 58,59,60,61,63,64,69,70,75,76,77,78,79,80,81,84,85,90,92,95,96,97,99,100,101,102,103,104,105,106,107,108,109,110,111,121,124,135,140,141, 143,145,148,149,152,153,158,162,169,170,171,175,179,180,194,195,198,203,205,210,211,212,213,214,215,216,217,218,219,220,221,222,223,225,226,230,233,242,251,256,257,258,262,265,267,268,271,274,279,292,293,294,296,297,303,306,308,309,311,314,315,316,317,320,321,323,325,326,331,332,341,342,347,352,356,359,360,361,364,369,370,374,375,380,386,389,390,392,393,394,399,403,405,406,407,408,410,411,412,413};
    private final int[] vegan3 = new int[]{1, 2, 3, 4, 6, 7, 11, 19, 21, 25, 26, 30, 31, 32, 33, 38, 39, 40, 42, 43, 47, 48, 53, 58,59,60,61,63,64,69,70,75,77,78,79,80,81,84,85,86,90,92,95,96,97,99,100,101,102,103,104,105,106,107,108,109,110,111,115,118,124,134,135,139,140,141,145,148,149,152,153,158,161,162,169,171,173,175,179,180,187,194,195,198,203,204,205,210,211,212,213,214,215,216,217,218,219,220,221,222,223,225,226,233,238,242,251,256,257,258,262,265,267,268,269,271,274,279,288,289,290,292,293,294,296,297,306,308,309,311,314,315,316,317,321,323,325,326,331,332,339,342,347,349,352,364,386,389,390,392,393,394,402,403,405,406,407,408,410,411,412};
    private final int[] vegan4 = {1,2,3,4,6,7,11,19,21,25,26,30,31,32,33,38,39,40,42,43,47,48,53,58,59,60,61,63,64,69,70,75,77,78,79,80,81,84,85,90,92,95,96,97,99,100,101,102,103,104,105,106,107,108,109,110,111,121,124,134,135,139,140,141,143,145,148,149,152,153,158,162,169,170,171,173,175,179,180,194,195,198,203,204,205,210,211,212,213,214,215,216,217,218,219,220,221,222,223,225,226,230,233,242,251,256,257,258,262,265,267,268,271,274,279,288,289,290,292,293,294,296,297,303,306,308,309,311,314,315,316,317,320,321,323,325,326,331,332,341,342,347,352,356,359,360,361,364,369,370,374,375,380,386,389,390,392,393,394,399,403,405,406,407,408,410,411,412,413};
    private final int[] vegan5 = {1,6,75,77,78,79,80,81,95,96,97,100,101,102,103,104,105,106,107,108,109,110,111,148,149,169,180,194,203,211,212,213,214,215,216,217,218,219,220,221,222,223,225,233,256,257,258,262,271,274,292,296,297,389,394,410};
    private final int[] vegan6 = {1,6,95,96,97,100,101,102,103,104,105,106,107,108,109,110,111,149,194,211,212,213,214,215,216,217,218,219,220,221,222,223,225,233,256,257,258,262,271,292,296,297,389,394,410};
    private final int[] vegan7 = {};

    public int veganIdToIngredient(User user, int veganId){
        try{
            switch (veganId){
                case 1:
                    for(int ingrId : vegan1){
                        ingredientPreferenceRepository.findByUserAndIngredient(user, ingredientRepository.findByIngrId(ingrId).get()).get().updatePrefRating(-50);
                    }
                case 2:
                    for(int ingrId : vegan2){
                        ingredientPreferenceRepository.findByUserAndIngredient(user, ingredientRepository.findByIngrId(ingrId).get()).get().updatePrefRating(-50);
                    }
                case 3:
                    for(int ingrId : vegan3){
                        ingredientPreferenceRepository.findByUserAndIngredient(user, ingredientRepository.findByIngrId(ingrId).get()).get().updatePrefRating(-50);
                    }
                case 4:
                    for(int ingrId : vegan4){
                        ingredientPreferenceRepository.findByUserAndIngredient(user, ingredientRepository.findByIngrId(ingrId).get()).get().updatePrefRating(-50);
                    }
                case 5:
                    for(int ingrId : vegan5){
                        ingredientPreferenceRepository.findByUserAndIngredient(user, ingredientRepository.findByIngrId(ingrId).get()).get().updatePrefRating(-50);
                    }
                case 6:
                    for(int ingrId : vegan6){
                        ingredientPreferenceRepository.findByUserAndIngredient(user, ingredientRepository.findByIngrId(ingrId).get()).get().updatePrefRating(-50);
                    }
                case 7:
            }
            return 1;
        } catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

}
