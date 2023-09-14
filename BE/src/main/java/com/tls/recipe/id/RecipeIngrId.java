package com.tls.recipe.id;

import java.io.Serializable;
import java.util.Objects;

public class RecipeIngrId implements Serializable {

    private int recipeId;
    private int ingrId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RecipeIngrId that = (RecipeIngrId) o;
        return Objects.equals(recipeId, that.recipeId) &&
            Objects.equals(ingrId, that.ingrId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(recipeId, ingrId);
    }

}
