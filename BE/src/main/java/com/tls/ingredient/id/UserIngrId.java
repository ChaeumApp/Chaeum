package com.tls.ingredient.id;

import java.io.Serializable;
import java.util.Objects;

public class UserIngrId implements Serializable {

    int userId;
    int ingrId;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        UserIngrId that = (UserIngrId) o;
        return Objects.equals(userId, that.userId) &&
            Objects.equals(ingrId, that.ingrId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, ingrId);
    }
}
