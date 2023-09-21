package com.tls.notification.id;

import java.io.Serializable;
import java.util.Objects;

public class UserDeviceTokenId implements Serializable {

    private int userId;
    private String tokenId;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        UserDeviceTokenId that = (UserDeviceTokenId) o;
        return Objects.equals(userId, that.userId) &&
            Objects.equals(tokenId, that.tokenId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, tokenId);
    }
}
