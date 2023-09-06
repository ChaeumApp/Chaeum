package com.tls.user.service;

import com.tls.user.dto.UserDto;
import com.tls.user.entity.User;
import java.sql.Date;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Override
    public int userSignup(UserDto userDto) {
        try {
            User user = User.builder()
                .userEmail(userDto.getUserEmail())
                .userPwd(userDto.getUserPwd())
                .userBirthday(Date.valueOf(userDto.getUserBirthday()))
                .userGender(userDto.getUserGender())
                .userActivated(true)
                // .vegan()
                .build();
        } catch (Exception e) {
            return 406;
        }
        return 200;
    }
}
