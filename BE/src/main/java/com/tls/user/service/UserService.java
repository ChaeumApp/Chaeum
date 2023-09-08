package com.tls.user.service;

import com.tls.jwt.TokenDto;
import com.tls.user.dto.UserDto;

public interface UserService {

    int userSignup(UserDto userDto);

    TokenDto userLogin(String userEmail, String userPwd);

    int userLogout(TokenDto tokenDto);

    int checkEmail(String userEmail);

    int userUpdate(UserDto userDto);

    int findUserPwd(String userEmail, String userBirthday);

    int sendEmailAuthCode(String userEmail);

    int checkEmailAuthCode(String userEmail, int code);

    int deleteUser(String userEmail);
}
