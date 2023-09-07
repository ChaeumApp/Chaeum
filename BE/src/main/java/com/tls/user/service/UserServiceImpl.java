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

    @Override
    public int checkEmail(String userEmail) {
        return 0;
    }

    @Override
    public int userUpdate(UserDto userDto) {
        return 0;
    }

    @Override
    public int findUserPwd(String userEmail, String userBirthday) {
        return 0;
    }

    @Override
    public int sendEmailAuthCode(String userEmail) {
        return 0;
    }

    @Override
    public int checkEmailAuthCode(String userEmail, int code) {
        return 0;
    }
}
