package com.tls.user.controller;

import com.tls.jwt.TokenDto;
import com.tls.user.dto.UserDto;
import com.tls.user.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Api(value = "유저 API", description = "회원 관련 API 입니다.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @PostMapping("/signup")
    @Operation(summary = "회원가입 메서드", description = "회원 정보를 넘겨주면 회원가입을 처리합니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "success"),
        @ApiResponse(responseCode = "406", description = "fail")
    })
    public ResponseEntity<?> userSignup(@RequestBody UserDto userDto) {
        log.info("userSignup call:: {}", userDto);
        int resultCode = userService.userSignup(userDto);
        if (resultCode == 200) {
            return new ResponseEntity<>("ok", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @PostMapping("/login")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "success"),
        @ApiResponse(responseCode = "406", description = "fail")
    })
    @Operation(summary = "로그인 메서드", description = "유저 정보를 넘겨주면 로그인을 시도한다.")
    public ResponseEntity<?> userLogin(@RequestBody UserDto userDto) {
        log.info("userLogin call:: {} / {}", userDto.getUserEmail(), userDto.getUserPwd());
        TokenDto tokenDto = userService.userLogin(userDto.getUserEmail(), userDto.getUserPwd());
        return new ResponseEntity<>(tokenDto, HttpStatus.OK);
    }

    @PostMapping("/logout")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "success"),
        @ApiResponse(responseCode = "406", description = "fail")
    })
    @Operation(summary = "로그아웃 메서드", description = "유저 정보를 넘겨주면 로그아웃을 시도한다.")
    public ResponseEntity<?> userLogout(@RequestHeader("Authorization") String tokenWithPrefix) {
        log.info("userLogout call");

        String token = tokenWithPrefix.substring(7);
        TokenDto tokenDto = new TokenDto();
        tokenDto.setAccessToken(token);
        tokenDto.setGrantType("Bearer");

        int resultCode = userService.userLogout(tokenDto);
        if (resultCode == 200) {
            log.debug("logout 성공");
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            log.info("logout 실패");
            return new ResponseEntity<>("fail", HttpStatus.NOT_ACCEPTABLE);
        }
    }
}
