package com.tls.user.repository;

import com.tls.user.entity.User;
import java.util.Date;
import java.util.Optional;
import org.springframework.data.repository.Repository;

public interface UserRepository extends Repository<User, String> {

    Optional<User> findByUserEmail(String userEmail);

    Optional<User> findByUserEmailAndUserBirthday(String userEmail, Date userBirthday);

    void save(User user);

}
