package com.tls.user.service;

import com.tls.jwt.TokenDto;
import com.tls.user.dto.UserDto;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Override
    public int userSignup(UserDto userDto) {
        return 200;
    }

    @Override
    public TokenDto userLogin(String userEmail, String userPwd) {
        return null;
    }

    @Override
    public int userLogout(TokenDto tokenDto) {
        return 0;
    }
}
