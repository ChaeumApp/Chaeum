package com.tls.user.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tls.jwt.JwtTokenProvider;
import com.tls.user.converter.UserConverter;
import com.tls.user.dto.UserDto;
import com.tls.user.entity.User;
import com.tls.user.repository.UserRepository;

import java.sql.Date;
import java.util.Objects;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Service
@RequiredArgsConstructor
public class OAuthService {

    /*
    private final UserRepository userRepository;
    private final CustomUserDetailsService customUserDetailsService;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;
    private final UserConverter userConverter;

    @Value("${spring.security.oauth2.client.registration.kakao.client-id}")
    private String KAKAO_CLIENT_ID;

    @Value("${spring.security.oauth2.client.registration.kakao.redirect-uri}")
    private String KAKAO_REDIRECT_URI;

    @Value("${spring.security.oauth2.client.registration.naver.client-id}")
    private String NAVER_CLIENT_ID;

    @Value("${spring.security.oauth2.client.registration.naver.client-secret}")
    private String NAVER_CLIENT_SECRET;

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

        String accessToken = Objects.requireNonNull(getAccessToken(code)).get("access_token").asText();
        if (getUserInfo(accessToken) != null) {
            String email = Objects.requireNonNull(getUserInfo(accessToken)).get("email").asText();
            String gender = Objects.requireNonNull(getUserInfo(accessToken)).get("gender").asText();
            String birthday = Objects.requireNonNull(getUserInfo(accessToken)).get("birthday").asText();
            String birthyear = Objects.requireNonNull(getUserInfo(accessToken)).get("birthyear").asText();
            User user = registerUserIfNeed(email, birthyear + "-" + birthday, gender);
//            String jwtToken = usersAuthorizationInput(user);
            return user != null ? userConverter.entityToDto(user) : null;
        }
        return null;
    }

    private JsonNode getAccessToken(String code) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-type", "application/x-www-form-urlencoeded;charset=utf-8");

        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("grant_type", "authorization_code");
        body.add("client_id", CLIENT_ID);
        if (TYPE.equals("naver")) body.add("client_secret", NAVER_CLIENT_SECRET);
        body.add("redirect_uri", REDIRECT_URI);
        body.add("code", code);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body, headers);
        RestTemplate rt = new RestTemplate();
        ResponseEntity<String> response;

        if (TYPE.equals("kakao")) {
            response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST, request, String.class);
        } else {
            response = rt.exchange("https://nid.anver.com/oauth2.0/token", HttpMethod.POST, request, String.class);
        }

        String responseBody = response.getBody();
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.readTree(responseBody);
        } catch (Exception e) {
            return null;
        }
    }

    private JsonNode getUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer" + accessToken);
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(headers);
        RestTemplate rt = new RestTemplate();
        ResponseEntity<String> response;

        if (TYPE.equals("kakao")) {
            response = rt.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST, request, String.class);
        } else {
            response = rt.exchange("https://openapi.naver.com/v1/nid/me", HttpMethod.POST, request, String.class);
        }

        String responseBody = response.getBody();
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(responseBody);

            if (TYPE.equals("kakao")) {
                return jsonNode.get("kakao-account");
            } else {
                return jsonNode.get("response");
            }
        } catch (Exception e) {
            return null;
        }
    }

    private User registerUserIfNeed(String email, String birthday, String gender) {
        User user = userRepository.findByUserEmail(email).orElse(null);
        if (user == null) {
            user = User.builder().userEmail(email).userPwd(passwordEncoder.encode(TYPE)).userBirthday(Date.valueOf(birthday)).userGender(gender).build();
            userRepository.save(user);
        }
        return user;
    }

//    private String usersAuthorizationInput(User user) {
//        return null;
//    }

//    private Boolean checkIsMember(User user) {
//        return user.getUserEmail() != null;
//    }

     */
}
