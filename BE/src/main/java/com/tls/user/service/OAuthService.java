package com.tls.user.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tls.jwt.JwtTokenProvider;
import com.tls.user.converter.UserConverter;
import com.tls.user.repository.UserRepository;

import com.tls.user.vo.UserKakaoVO;
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
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Service
@RequiredArgsConstructor
public class OAuthService {

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

//    @Value("${spring.security.oauth2.provider.naver.user-info-uri}")
//    private String NAVER_USER_INFO_URI;

    private String TYPE;
    private String CLIENT_ID;
    private String REDIRECT_URI;

    public UserKakaoVO signUp(String accessToken, String type) {
        TYPE = type;

        if (type.equals("kakao")) {
            CLIENT_ID = KAKAO_CLIENT_ID;
            REDIRECT_URI = KAKAO_REDIRECT_URI;
        } else if (type.equals("naver")) {
            CLIENT_ID = NAVER_CLIENT_ID;
            REDIRECT_URI = NAVER_REDIRECT_URI;
        }

        if (getUserInfo(accessToken) != null) {
            UserKakaoVO vo = new UserKakaoVO();
            String email = Objects.requireNonNull(getUserInfo(accessToken)).get("email").asText();
            vo.setUserEmail("[S]" + email);
            if (userRepository.findByUserEmail(email).isPresent()) {
                vo.setMsg("dup");
                return vo;
            }

            String gender, birthday, birthyear = "0000";
            if (type.equals("kakao")) {
                gender = Objects.requireNonNull(getUserInfo(accessToken)).get("gender").asText().substring(0, 1);
                birthday = Objects.requireNonNull(getUserInfo(accessToken)).get("birthday").asText();
            } else {
                gender = Objects.requireNonNull(getUserInfo(accessToken)).get("gender").asText().toLowerCase();
                birthday = Objects.requireNonNull(getUserInfo(accessToken)).get("birthday").asText().replace("-", "");
                birthyear = Objects.requireNonNull(getUserInfo(accessToken)).get("birthyear").asText();
            }
            vo.setUserPwd("");
            vo.setUserGender(gender);
            vo.setBirth(birthyear + birthday);
            log.info(vo.toString());
            return vo;
        }
        log.info("error");
        return null;
    }

    private JsonNode getUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);
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
            log.info(jsonNode.toString());

            if (TYPE.equals("kakao")) {
                return jsonNode.get("kakao_account");
            } else {
                return jsonNode.get("response");
            }
        } catch (Exception e) {
            return null;
        }
    }
}
