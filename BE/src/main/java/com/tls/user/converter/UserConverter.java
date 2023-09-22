package com.tls.user.converter;

import com.tls.user.dto.UserDto;
import com.tls.user.entity.User;
import com.tls.user.repository.VeganRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Component
@RequiredArgsConstructor
public class UserConverter {

    private final VeganRepository veganRepository;

    public UserDto entityToDto(User user) {
        return new UserDto(
                user.getUserId(),
                user.getUserEmail(),
                user.getUserPwd(),
                user.getUserBirthday().toString(),
                user.getUserGender(),
                user.getUserActivated(),
                user.getVegan().getVeganId()
        );
    }

    public User dtoToEntity(UserDto userDto) {
            return User.builder()
                    .userId(userDto.getUserId())
                    .userEmail(userDto.getUserEmail())
                    .userPwd(userDto.getUserPwd())
                    .userBirthday(Date.valueOf(userDto.getUserBirthday().substring(0, 10)))
                    .userGender(userDto.getUserGender())
                    .userActivated(userDto.getUserActivated())
                    .vegan(veganRepository.findByVeganId(userDto.getVeganId()).orElse(null))
                    .build();
    }
}
