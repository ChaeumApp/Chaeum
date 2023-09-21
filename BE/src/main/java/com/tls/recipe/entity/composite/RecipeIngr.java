package com.tls.recipe.entity.composite;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.recipe.entity.single.Recipe;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
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
public class RecipeIngr {

    @Id
    @Column(name = "recipe_ingr_pk")
    private long recipIngrPk;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id")
    private Recipe recipeId;

    @Column(name = "recipe_ingr_name")
    private String RecipeIngrName;

    @Column(name = "recipe_ingr_amount")
    private String RecipeIngrAmount;
}
