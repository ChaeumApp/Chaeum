package com.tls.recipe.entity.composite;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.id.RecipeIngrId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "recipe_ingredient_tb")
@IdClass(RecipeIngrId.class)
public class RecipeIngr {

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id")
    private Recipe recipeId;

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingr_id")
    private Ingredient ingrId;
}
