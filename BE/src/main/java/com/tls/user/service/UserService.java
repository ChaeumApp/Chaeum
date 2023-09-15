package com.tls.user.service;

import com.tls.jwt.TokenDto;
import com.tls.user.dto.UserDto;

public interface UserService {

    int signUp(UserDto userDto);

    TokenDto signIn(String userEmail, String userPwd);

    int signOut(TokenDto tokenDto);

    int checkEmail(String userEmail);

    int updateUser(UserDto userDto);

    int findUserPwd(String userEmail, String userBirthday);

    int sendEmailAuthCode(String userEmail);

    int checkEmailAuthCode(String userEmail, int code);

    int deleteUser(String userEmail);

    int readProfile(String userEmail);
}
