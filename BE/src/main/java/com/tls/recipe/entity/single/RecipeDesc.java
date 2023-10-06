package com.tls.recipe.entity.single;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "recipe_description_tb")
@DynamicInsert
public class RecipeDesc {

    @Id
    @Column(name = "recipe_id")
    private int recipeId;

    @Column(name = "recipe_description")
    private String recipeDescription;
}
