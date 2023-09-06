package com.tls.user.service;

import com.tls.jwt.TokenDto;
import com.tls.user.dto.UserDto;

public interface UserService {

    int userSignup(UserDto userDto);

    TokenDto userLogin(String userEmail, String userPwd);
}
