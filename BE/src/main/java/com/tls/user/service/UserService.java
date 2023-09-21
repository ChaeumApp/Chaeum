package com.tls.user.service;

import com.tls.jwt.TokenDto;
import com.tls.user.vo.UserPwdVO;
import com.tls.user.vo.UserSignInVO;
import com.tls.user.vo.UserSignUpVO;

public interface UserService {

    int signUp(UserSignUpVO userDto);

    TokenDto signIn(UserSignInVO userSignInVO);

    int signOut(TokenDto tokenDto);

    int checkEmail(String userEmail);

    int updateUserInfo(String userEmail, UserSignUpVO userVO);

    int updateUserPwd(String userEmail, UserPwdVO userVO);

    int findUserPwd(String userEmail, String userBirthday);

    int sendEmailAuthCode(String userEmail);

    int checkEmailAuthCode(String userEmail, int code);

    int deleteUser(String userEmail);

    int readProfile(String userEmail);
}
