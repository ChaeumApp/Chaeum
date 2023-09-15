package com.tls.recipe.id;

import java.io.Serializable;
import java.util.Objects;

public class RecipeProcId implements Serializable {

    private int recipeId;
    private int recipeProcId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RecipeProcId that = (RecipeProcId) o;
        return Objects.equals(recipeId, that.recipeId) &&
            Objects.equals(recipeProcId, that.recipeProcId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(recipeId, recipeProcId);
    }
}
