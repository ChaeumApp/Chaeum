package com.tls.recipe.entity.composite;

import com.tls.Ingredient.entity.single.Ingredient;
import com.tls.recipe.entity.single.Recipe;
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
public class RecipeIngredient {

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id")
    private Recipe recipe;

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingr_id")
    private Ingredient ingredient;
}
