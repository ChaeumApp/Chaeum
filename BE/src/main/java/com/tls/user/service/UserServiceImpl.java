package com.tls.user.service;

import com.tls.user.dto.UserDto;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Override
    public int userSignup(UserDto userDto) {
        return 200;
    }
}
