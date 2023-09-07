package com.tls.user.controller;

import com.tls.jwt.JwtTokenProvider;
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
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Api(tags = "유저 API", description = "회원 관련 API 입니다.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/signup")
    @Operation(summary = "회원가입 메서드", description = "회원 정보를 넘겨주면 회원가입을 처리합니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "회원가입 성공하면 ok 를 반환한다."),
        @ApiResponse(responseCode = "406", description = "회원가입 중 오류발생 시 fail 을 반환한다.")
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
    @Operation(summary = "로그인 메서드", description = "유저 정보를 넘겨주면 로그인을 시도한다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "로그인에 성공하면 TokenDto를 반환한다."),
        @ApiResponse(responseCode = "406", description = "로그인 시도 중 오류 발생")
    })
    public ResponseEntity<?> userLogin(@RequestBody UserDto userDto) {
        log.info("userLogin call:: {} / {}", userDto.getUserEmail(), userDto.getUserPwd());
        TokenDto tokenDto = userService.userLogin(userDto.getUserEmail(), userDto.getUserPwd());
        return new ResponseEntity<>(tokenDto, HttpStatus.OK);
    }

    @PostMapping("/logout")
    @Operation(summary = "로그아웃 메서드", description = "유저 정보를 넘겨주면 로그아웃을 시도한다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "success"),
        @ApiResponse(responseCode = "406", description = "fail")
    })
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

    @GetMapping("/checkemail")
    @Operation(summary = "이메일 중복 확인 메서드", description = "이메일을 주면 중복된 이메일인지 확인하는 메서드")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "success/fail 사용가능/불가능 여부 반환한다."),
        @ApiResponse(responseCode = "406", description = "이메일 중복확인 중 오류발생 시 fail을 반환한다.")
    })
    public ResponseEntity<String> checkEmail(@RequestParam String userEmail) {
        log.info("checkEmail call :: {}", userEmail);
        int result = userService.checkEmail(userEmail);
        if (result == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else if (result == 0) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping(value = "/change")
    @Operation(summary = "회원정보 수정 메서드", description = "내 프로필의 정보를 수정할 수 있습니다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "업데이트에 성공하면 success 를 반환한다."),
        @ApiResponse(responseCode = "401", description = "업데이트할 정보와 현재 로그인한 정보가 일치하지 않으면 unauthorized 를 반환한다."),
        @ApiResponse(responseCode = "500", description = "업데이트에 실패하면 fail 을 반환한다.")
    })
    public ResponseEntity<?> userUpdate(@RequestBody UserDto userDto,
        @RequestHeader("Authorization") String tokenWithPrefix) {
        log.info("findUserPwd call :: {}", userDto.getUserEmail());
        // Token을 받아 인증 정보를 추출한다.(수정하려는 user정보와 현재 로그인한 user 정보가 일치할 경우에만 수정가능 하도록 하기 위함)
        Authentication authentication = jwtTokenProvider.getAuthentication(
            tokenWithPrefix.substring(7));
        if (userDto.getUserEmail().equals(authentication.getName())) { // 만약 인증 정보와 일치하면
            int responseCode = userService.userUpdate(userDto);
            if (responseCode == 1) {
                return new ResponseEntity<>("success", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        return new ResponseEntity<>("unauthorized", HttpStatus.UNAUTHORIZED);
    }

    @PostMapping(value = "/find/pwd")
    @Operation(summary = "비밀번호 찾기", description = "이메일과 생년월일을 입력하면 해당 이메일로 임시비밀번호를 발급해준다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "업데이트에 성공하면 success 를 반환한다."),
        @ApiResponse(responseCode = "401", description = "생일과 이메일이 일치하지 않으면 unauthorized 를 반환한다."),
        @ApiResponse(responseCode = "500", description = "업데이트에 실패하면 fail 을 반환한다.")
    })
    public ResponseEntity<?> findUserPwd(@RequestBody UserDto userDto) {
        log.info("findUserPwd call :: {}", userDto.getUserEmail());
        int resultCode = userService.findUserPwd(userDto.getUserEmail(), userDto.getUserBirthday());
        if (resultCode == 0) {
            return new ResponseEntity<>("unauthorized", HttpStatus.UNAUTHORIZED);
        } else if (resultCode == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/auth/sendEmail")
    @Operation(summary = "이메일 인증 코드 전송 메서드", description = "회원가입을 위한 이메일 입력시 해당 이메일로 인증번호를 전송해준다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "이메일 인증 코드 전송에 성공하면 success 를 반환한다."),
        @ApiResponse(responseCode = "500", description = "이메일 인증 코드 전송에 실패하면 fail 을 반환한다.")
    })
    public ResponseEntity<?> sendEmailAuth(@RequestBody String userEmail) {
        log.info("sendEmailAuth call :: sending email to : {}", userEmail);

        int resultCode = userService.sendEmailAuthCode(userEmail);
        if (resultCode == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/auth/checkEmail/{code}")
    @Operation(summary = "회원가입 시 입력된 이메일로 전송된 인증번호를 검증한다.", description = "이메일 가입을 위한 이메일 인증번호 확인")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "이메일 인증에 성공하면 success 를 반환한다."),
        @ApiResponse(responseCode = "401", description = "이메일 인증 코드가 일치하지 않을 경우 unauthorized 를 반환한다."),
        @ApiResponse(responseCode = "500", description = "서버 오류 발생 시 fail 을 반환한다.")
    })
    public ResponseEntity<?> checkEmailAuth(@RequestBody String userEmail,
        @PathVariable("code") int code) {
        log.info("checkEmailAuth call :: email : {} , code : {}", userEmail, code);
        int resultCode = userService.checkEmailAuthCode(userEmail, code);
        if (resultCode == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else if (resultCode == 0) {
            return new ResponseEntity<>("unauthorized", HttpStatus.UNAUTHORIZED);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}