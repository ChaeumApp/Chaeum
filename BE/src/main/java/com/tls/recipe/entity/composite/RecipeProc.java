package com.tls.recipe.entity.composite;

import com.tls.recipe.entity.single.Recipe;
import com.tls.recipe.id.RecipeProcId;
import javax.persistence.Column;
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
@Table(name = "recipe_process_tb")
@IdClass(RecipeProcId.class)
public class RecipeProc {

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id")
    private Recipe recipeId;

    @Id
    @Column(name = "recipe_proc_id")
    private int recipeProcId;

    @Column(name = "recipe_proc_content")
    private String recipeProcContent;
}
