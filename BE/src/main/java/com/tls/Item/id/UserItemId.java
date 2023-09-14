package com.tls.Item.id;

import java.io.Serializable;
import java.util.Objects;

public class UserItemId implements Serializable {
    private int userId;
    private long itemId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserItemId that = (UserItemId) o;
        return Objects.equals(userId, that.userId) &&
            Objects.equals(itemId, that.itemId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, itemId);
    }
}
