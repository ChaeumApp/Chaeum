package com.tls.allergy.id;

import java.io.Serializable;
import java.util.Objects;

public class UserAllergyId implements Serializable {
    private int userId;
    private int algyId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserAllergyId that = (UserAllergyId) o;
        return Objects.equals(userId, that.userId) &&
            Objects.equals(algyId, that.algyId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, algyId);
    }

}
