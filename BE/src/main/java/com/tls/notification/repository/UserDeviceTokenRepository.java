package com.tls.notification.repository;

import com.tls.notification.entity.composite.UserDeviceToken;
import com.tls.notification.id.UserDeviceTokenId;
import com.tls.user.entity.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface UserDeviceTokenRepository extends
    
    Repository<UserDeviceToken, UserDeviceTokenId> {

    Optional<List<UserDeviceToken>> findAllByUserId(User userId);

    void save(UserDeviceToken userDeviceToken);
}
