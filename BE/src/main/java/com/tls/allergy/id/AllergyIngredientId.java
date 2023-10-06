package com.tls.allergy.id;

import java.io.Serializable;
import java.util.Objects;

public class AllergyIngredientId implements Serializable {

    private int algyId;
    private int ingrId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AllergyIngredientId that = (AllergyIngredientId) o;
        return Objects.equals(algyId, that.algyId) &&
            Objects.equals(ingrId, that.ingrId);
    }
    @Override
    public int hashCode() {
        return Objects.hash(algyId, ingrId);
    }
}
