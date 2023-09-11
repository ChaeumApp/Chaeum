package com.tls.user.service;

import com.tls.jwt.JwtTokenProvider;
import com.tls.user.dto.UserDto;
import com.tls.user.entity.User;
import com.tls.user.repository.UserRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OAuthService {

    private final UserRepository userRepository;
    private final CustomUserDetailsService customUserDetailsService;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    @Value("${spring.security.oauth2.client.registration.kakao.client-id}")
    private String KAKAO_CLIENT_ID;

    @Value("${spring.security.oauth2.client.registration.kakao.redirect-uri}")
    private String KAKAO_REDIRECT_URI;

    @Value("${spring.security.oauth2.client.registration.naver.client-id}")
    private String NAVER_CLIENT_ID;

    @Value("${spring.security.oauth2.client.registration.naver.client-secret}")
    private String KAKAO_CLIENT_SECRET;

    @Value("${spring.security.oauth2.client.registration.naver.redirect-uri}")
    private String NAVER_REDIRECT_URI;

    @Value("${spring.security.oauth2.provider.naver.user-info-uri}")
    private String NAVER_USER_INFO_URI;

    private String TYPE;
    private String CLIENT_ID;
    private String REDIRECT_URI;

    public UserDto signUp(String code, String type) {
        TYPE = type;

        if (type.equals("kakao")) {
            CLIENT_ID = KAKAO_CLIENT_ID;
            REDIRECT_URI = KAKAO_REDIRECT_URI;
        } else if (type.equals("naver")) {
            CLIENT_ID = NAVER_CLIENT_ID;
            REDIRECT_URI = NAVER_REDIRECT_URI;
        }

        String kakaoAccessToken = getAccessToken(code);
        String email = getUserInfo(kakaoAccessToken);
        User user = registerUserIfNeed(email);
        String jwtToken = usersAuthorizationInput(user);
        Boolean isMember = checkIsMember(user);

        return new UserDto();
    }

    private String getAccessToken(String code) {
        return null;
    }

    private String getUserInfo(String accessToken) {
        return null;
    }

    private User registerUserIfNeed(String email) {
        Optional<User> user = userRepository.findByUserEmail(email);
        if (user.isPresent()) {
            return userRepository.findByUserEmail(email).get();
        }
        return null;
    }

    private String usersAuthorizationInput(User user) {
        return null;
    }

    private Boolean checkIsMember(User user) {
        return true;
    }
}
