package com.tls.user.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tls.user.repository.UserRepository;

import com.tls.user.vo.UserKakaoVO;
import java.util.Objects;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Service
@RequiredArgsConstructor
public class OAuthService {

    private final UserRepository userRepository;

    private String TYPE;

    public UserKakaoVO signUp(String accessToken, String type) {
        TYPE = type;

        if (getUserInfo(accessToken) != null) {
            UserKakaoVO vo = new UserKakaoVO();
            String email = Objects.requireNonNull(getUserInfo(accessToken)).get("email").asText();
            if (TYPE.equals("kakao")) vo.setUserEmail("[K]" + email);
            else if (TYPE.equals("naver")) vo.setUserEmail("[N]" + email);
            if (userRepository.findByUserEmail(vo.getUserEmail()).isPresent()) {
                vo.setMsg("dup");
                return vo;
            }

            String gender, birthday, birthyear = "0000";
            JsonNode result = getUserInfo(accessToken);
            if (type.equals("kakao")) {
                gender = result.get("gender_needs_agreement").asText().equals("false") ?
                    Objects.requireNonNull(result.get("gender").asText().substring(0, 1)) : null;
                log.info("gender: {}", gender);
                birthday = result.get("birthday_needs_agreement").asText().equals("false") ?
                    Objects.requireNonNull(result.get("birthday").asText()) : null;
                log.info("birthday: {}", birthday);
            } else {
                gender = Objects.requireNonNull(result).get("gender").asText().toLowerCase();
                birthday = Objects.requireNonNull(result).get("birthday").asText().replace("-", "");
                birthyear = Objects.requireNonNull(result).get("birthyear").asText();
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