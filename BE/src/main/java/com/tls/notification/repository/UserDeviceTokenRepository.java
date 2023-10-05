package com.tls.notification.repository;

import com.tls.notification.entity.composite.UserDeviceToken;
import com.tls.notification.id.UserDeviceTokenId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDeviceTokenRepository extends JpaRepository<UserDeviceToken, UserDeviceTokenId> {

}
