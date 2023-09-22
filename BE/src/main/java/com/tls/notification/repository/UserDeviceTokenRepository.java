package com.tls.notification.repository;

import com.tls.notification.entity.composite.UserDeviceToken;
import com.tls.notification.id.UserDeviceTokenId;
import com.tls.user.entity.User;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface UserDeviceTokenRepository extends
    
    Repository<UserDeviceTokenId, UserDeviceTokenId> {

    Optional<UserDeviceToken> findByUserId(User userId);

    void save(UserDeviceToken userDeviceToken);
}
