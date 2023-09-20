package com.tls.user.controller;

import com.tls.config.RandomStringCreator;
import com.tls.jwt.JwtTokenProvider;
import com.tls.jwt.TokenDto;
import com.tls.user.repository.UserRepository;
import com.tls.user.service.OAuthService;
import com.tls.user.service.UserService;
import com.tls.user.vo.UserEmailVO;
import com.tls.user.vo.UserFindPwdVO;
import com.tls.user.vo.UserKakaoVO;
import com.tls.user.vo.UserPwdVO;
import com.tls.user.vo.UserSignUpVO;
import com.tls.user.vo.UserSignInVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
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
@Tag(name = "유저 API", description = "회원 관련 API 입니다.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final OAuthService oAuthService;
    private final JwtTokenProvider jwtTokenProvider;
    private final UserRepository userRepository;
    private RandomStringCreator rsc;

    @PostMapping("/signup")
    @Operation(summary = "회원가입 메서드", description = "회원 정보를 넘겨주면 회원가입을 처리합니다.", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "회원가입 성공하면 ok 를 반환한다.")
    })
    public ResponseEntity<?> signUp(@RequestBody UserSignUpVO userDto) {
        log.info("signUp call:: {}", userDto);
        if (userDto.getUserPwd().isEmpty()) {
            userDto.setUserEmail("[S]"+userDto.getUserEmail());
            userDto.setUserPwd(rsc.getRandomString(20));
        }
        int resultCode = userService.signUp(userDto);
        if (resultCode == 200) {
            TokenDto tokenDto = userService.signIn(userDto.getUserEmail(), userDto.getUserPwd());
            if (tokenDto != null) {
                log.debug("signin 성공");
                return new ResponseEntity<>(tokenDto, HttpStatus.OK);
            } else {
                log.debug("signin 실패");
                return new ResponseEntity<>("signin fail", HttpStatus.OK);
            }
        } else {
            return new ResponseEntity<>("signup fail", HttpStatus.OK);
        }
    }

//    @GetMapping("/oAuth/naver")
//    @Operation(summary = "네이버 로그인 메서드", description = "네이버 로그인을 시도한다.")
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "네이버 로그인에 성공하면 success를 반환한다."),
//        @ApiResponse(responseCode = "406", description = "네이버 로그인 시도 중 오류 발생 시 fail을 반환한다.")
//    })
//    public ResponseEntity<?> signUpN(@RequestParam(name = "") String code) {
//        try {
//            return ResponseEntity.ok(oAuthService.signUp(code, "naver"));
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<>("fail", HttpStatus.NOT_ACCEPTABLE);
//        }
//    }

    @GetMapping("/oAuth/kakao")
    @Operation(summary = "카카오 로그인 메서드", description = "카카오 로그인을 시도한다.")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "카카오 로그인에 성공하면 success를 반환한다."),
        @ApiResponse(responseCode = "406", description = "카카오 로그인 시도 중 오류 발생 시 fail을 반환한다.")
    })
    public ResponseEntity<?> signUpK(@RequestParam(name = "token") String token) {
        try {
            UserKakaoVO vo = oAuthService.signUp(token, "kakao");
            if (vo.getMsg().equals("dup")) {
                TokenDto tokenDto = userService.signIn(vo.getUserEmail(), "");
                if (tokenDto != null) {
                    log.debug("signin 성공");
                    return new ResponseEntity<>(tokenDto, HttpStatus.OK);
                } else {
                    log.debug("signin 실패");
                    return new ResponseEntity<>("signin fail", HttpStatus.OK);
                }
            } else {
                return ResponseEntity.ok(oAuthService.signUp(token, "kakao"));
            }
        } catch (Exception e) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/signin")
    @Operation(summary = "로그인 메서드", description = "유저 정보를 넘겨주면 로그인을 시도한다.", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "로그인에 성공하면 success 를 반환한다.\n로그인에 실패하면 fail 을 반환한다.")
    })
    public ResponseEntity<?> signIn(@RequestBody UserSignInVO userDto) {
        log.info("signIn call:: {} / {}", userDto.getUserEmail(), userDto.getUserPwd());
        TokenDto tokenDto = userService.signIn(userDto.getUserEmail(), userDto.getUserPwd());
        if (tokenDto != null) {
            log.debug("signin 성공");
            return new ResponseEntity<>(tokenDto, HttpStatus.OK);
        } else {
            log.debug("signin 실패");
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/signout")
    @Operation(summary = "로그아웃 메서드", description = "유저 정보를 넘겨주면 로그아웃을 시도한다.", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "success")
    })
    public ResponseEntity<?> signOut(@RequestHeader("Authorization") String tokenWithPrefix) {
        log.info("signOut call");

        String token = tokenWithPrefix.substring(7);
        TokenDto tokenDto = new TokenDto();
        tokenDto.setAccessToken(token);
        tokenDto.setGrantType("Bearer");

        int resultCode = userService.signOut(tokenDto);
        if (resultCode == 200) {
            log.debug("signout 성공");
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            log.info("signout 실패");
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/checkemail")
    @Operation(summary = "이메일 중복 확인 메서드", description = "이메일을 주면 중복된 이메일인지 확인하는 메서드", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "success/fail 사용가능/불가능 여부 반환한다.")
    })
    public ResponseEntity<String> checkEmail(@RequestParam String userEmail) {
        log.info("checkEmail call :: {}", userEmail);
        int result = userService.checkEmail(userEmail);
        if (result == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else if (result == 0) {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("error", HttpStatus.OK);
        }
    }

    @PutMapping
    @Operation(summary = "회원정보 수정 메서드", description = "내 프로필의 정보를 수정할 수 있습니다.", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "업데이트에 성공하면 success 를 반환한다.\n"
            + "업데이트할 정보와 현재 로그인한 정보가 일치하지 않으면 unauthorized 를 반환한다.\n"
            + "업데이트에 실패하면 fail 을 반환한다.")
    })
    public ResponseEntity<?> updateUser(@RequestBody UserPwdVO userDto,
        @RequestHeader("Authorization") String tokenWithPrefix) {
        // Token을 받아 인증 정보를 추출한다.(수정하려는 user정보와 현재 로그인한 user 정보가 일치할 경우에만 수정가능 하도록 하기 위함)
        Authentication authentication = jwtTokenProvider.getAuthentication(
            tokenWithPrefix.substring(7));
        log.info("findUserPwd call :: {}", authentication.getName());
        int responseCode = userService.updateUser(authentication.getName(), userDto);
        if (responseCode == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping(value = "/find/pwd")
    @Operation(summary = "비밀번호 찾기 메서드", description = "이메일과 생년월일을 입력하면 해당 이메일로 임시비밀번호를 발급해준다.", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "업데이트에 성공하면 success 를 반환한다.\n"
            + "생일과 이메일이 일치하지 않으면 unauthorized 를 반환한다.\n"
            + "업데이트에 실패하면 fail 을 반환한다.")
    })
    public ResponseEntity<?> findUserPwd(@RequestBody UserFindPwdVO userDto) {
        log.info("findUserPwd call :: {}", userDto.getUserEmail());
        int resultCode = userService.findUserPwd(userDto.getUserEmail(),
            userDto.getUserBirthday().toString());
        if (resultCode == 0) {
            return new ResponseEntity<>("unauthorized", HttpStatus.OK);
        } else if (resultCode == 1) {
            log.info("{} 로 임시 비밀번호를 전송하였습니다.", userDto.getUserEmail());
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/auth/sendEmail")
    @Operation(summary = "이메일 인증 코드 전송 메서드", description = "회원가입을 위한 이메일 입력시 해당 이메일로 인증번호를 전송해준다.", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "이메일 인증 코드 전송에 성공하면 success 를 반환한다.\n"
            + "이메일 인증 코드 전송에 실패하면 fail 을 반환한다.")
    })
    public ResponseEntity<?> sendEmailAuth(@RequestBody UserEmailVO userEmail) {
        log.info("sendEmailAuth call :: sending email to : {}", userEmail);

        int resultCode = userService.sendEmailAuthCode(userEmail.getUserEmail());
        if (resultCode == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/auth/checkEmail/{code}")
    @Operation(summary = "이메일 인증번호 검증 메서드", description = "회원가입 시 이메일로 전송된 인증번호를 검증한다.", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "이메일 인증에 성공하면 success 를 반환한다.\n"
            + "이메일 인증 코드가 일치하지 않을 경우 unauthorized 를 반환한다.\n"
            + "서버 오류 발생 시 fail 을 반환한다.")
    })
    public ResponseEntity<?> checkEmailAuth(@RequestBody UserEmailVO userEmail,
        @PathVariable("code") int code) {
        log.info("checkEmailAuth call :: email : {} , code : {}", userEmail, code);
        int resultCode = userService.checkEmailAuthCode(userEmail.getUserEmail(), code);
        return getResponseEntity(resultCode);
    }

    @PostMapping("/auth/checktoken")
    @Operation(summary = "토큰 유효성 검사 메서드", description = "토큰 정보를 주면 유효성을 검사한다.", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "토큰 검증에 성공하면 success 를 반환한다.\n"
            + "토큰이 유효하지 않을 경우 unauthorized 를 반환한다.\n"
            + "서버 오류 발생 시 fail 을 반환한다.")
    })
    public ResponseEntity<?> checkToken(@RequestHeader("Authorization") String tokenWithPrefix) {
        log.info("checkToken call");
        try {
            if (jwtTokenProvider.validateToken(tokenWithPrefix.substring(7))) {
                return getResponseEntity(1);
            } else {
                return getResponseEntity(0);
            }
        } catch (Exception e) {
            return getResponseEntity(-1);
        }
    }

    @DeleteMapping
    @Operation(summary = "회원탈퇴 메서드", description = "회원 탈퇴를 위한 메서드", tags = "유저 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "회원 탈퇴에 성공하면 success 를 반환한다.\n"
            + "Token정보와 Email 주소가 않을 경우 unauthorized 를 반환한다.\n"
            + "서버 오류 발생 시 fail 을 반환한다.")
    })
    public ResponseEntity<?> deleteUser(@RequestHeader("Authorization") String tokenWithPrefix,
        @RequestBody UserEmailVO userEmail) {
        log.info("deleteUser call :: {}", userEmail);

        Authentication authentication = jwtTokenProvider.getAuthentication(
            tokenWithPrefix.substring(7));
        if (userEmail.getUserEmail().equals(authentication.getName())) { // 만약 인증 정보와 일치하면
            int resultCode = userService.deleteUser(userEmail.getUserEmail());
            if (resultCode == 1) { // 회원정보 삭제 성공했으면 로그아웃 처리 후 반환
                String token = tokenWithPrefix.substring(7);
                TokenDto tokenDto = new TokenDto();
                tokenDto.setAccessToken(token);
                tokenDto.setGrantType("Bearer");
                userService.signOut(tokenDto);
                return new ResponseEntity<>("success", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } else { // 인증정보와 현재 로그인한 정보가 일치하지 않으면
            return new ResponseEntity<>("unauthorized", HttpStatus.OK);
        }
    }

    @PostMapping(value = "/mypage")
    @Operation(summary = "회원정보 조회 메서드", description = "회원 정보 조회를 위한 메서드", tags = "유저 API")
    @ApiResponse(responseCode = "200", description = "조회에 성공하면 좋아요한 레시피, 좋아요 한 식재료 를 반환한다.\n"
        + "조회에 실패하면 fail 을 반환한다.\n"
        + "요청한 Email 정보와 Header 의 토큰 정보가 일치하지 않으면 unauthorized 를 반환한다.")
    public ResponseEntity<?> readProfile(@RequestBody UserEmailVO userIdVO,
        @RequestHeader("Authorization") String tokenWithPrefix) {
        log.info("회원정보 조회 call :: {}", userIdVO.toString());

        try {
            Authentication authentication = jwtTokenProvider.getAuthentication(
                tokenWithPrefix.substring(7));
            if (userIdVO.toString().equals(authentication.getName())) { // 만약 인증 정보와 일치하면
                return new ResponseEntity<>(userService.readProfile(userIdVO.getUserEmail()),
                    HttpStatus.OK);
            } else {
                return getResponseEntity(0);
            }
        } catch (Exception e) {
            return getResponseEntity(-1);
        }
    }

    private ResponseEntity<?> getResponseEntity(int resultCode) {
        if (resultCode == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else if (resultCode == 0) {
            return new ResponseEntity<>("unauthorized", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }
}