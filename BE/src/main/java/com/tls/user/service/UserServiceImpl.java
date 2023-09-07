package com.tls.user.service;

import com.tls.config.RandomStringCreator;
import com.tls.jwt.JwtTokenProvider;
import com.tls.jwt.TokenDto;
import com.tls.mail.MailDto;
import com.tls.mail.MailService;
import com.tls.user.dto.UserDto;
import com.tls.user.entity.User;
import com.tls.user.repository.UserRepository;
import com.tls.user.util.RedisUtil;
import io.jsonwebtoken.Jwts;
import java.sql.Date;
import java.util.Optional;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final AuthenticationManagerBuilder authenticationManagerBuilder;
    private final JwtTokenProvider jwtTokenProvider;
    private final RedisTemplate redisTemplate;
    private final UserRepository userRepository;
    private final RedisUtil redisUtil;
    private final MailService mailService;
    private final PasswordEncoder passwordEncoder;

    @Value("${jwt.secret}")
    private String secretkey;

    @Override
    public int userSignup(UserDto userDto) {
        return 200;
    }

    @Override
    public TokenDto userLogin(String userEmail, String userPwd) {
        // 1. Login ID/PW 를 기반으로 Authentication 객체 생성
        // 이때 authentication 는 인증 여부를 확인하는 authenticated 값이 false
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
            userEmail, userPwd);

        // 2. 실제 검증 (사용자 비밀번호 체크)이 이루어지는 부분
        // authenticate 매서드가 실행될 때 CustomUserDetailsService 에서 만든 loadUserByUsername 메서드가 실행
        Authentication authentication = authenticationManagerBuilder.getObject()
            .authenticate(authenticationToken);

        // 3. 인증 정보를 기반으로 JWT 토큰 생성
        TokenDto tokenDto = jwtTokenProvider.generateToken(authentication, userEmail);

        if (authentication.isAuthenticated()) {
            //redis에 RT:13@gmail.com(key) / 23jijiofj2io3hi32hiongiodsninioda(value) 형태로 리프레시 토큰 저장하기
            redisTemplate.opsForValue().set("RT:" + userEmail, tokenDto.getRefreshToken(), 86400000,
                TimeUnit.MILLISECONDS);
        }

        return tokenDto;
    }

    @Override
    @Transactional
    public int userLogout(TokenDto tokenDto) {
        // 로그아웃 하고 싶은 토큰이 유효한 지 먼저 검증하기
        if (!jwtTokenProvider.validateToken(tokenDto.getAccessToken())) {
            return -1;
        }
        try {
            // Access Token에서 User email을 가져온다
            Authentication authentication = jwtTokenProvider.getAuthentication(
                tokenDto.getAccessToken());

            // Redis에서 해당 User email로 저장된 Refresh Token 이 있는지 여부를 확인 후에 있을 경우 삭제를 한다.
            if (redisTemplate.opsForValue().get("RT:" + authentication.getName()) != null) {
                // Refresh Token을 삭제
                redisTemplate.delete("RT:" + authentication.getName());
            }

            // 해당 Access Token 유효시간을 가지고 와서 BlackList에 저장하기
            long expiration =
                Jwts.parser().setSigningKey(secretkey).parseClaimsJws(tokenDto.getAccessToken())
                    .getBody().getExpiration().getTime() - new java.util.Date().getTime();
            redisTemplate.opsForValue()
                .set(tokenDto.getAccessToken(), "logout", expiration, TimeUnit.MILLISECONDS);
            return 200;
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public int checkEmail(String userEmail) {
        try {
            if (userRepository.findByUserEmail(userEmail).isEmpty()) { // 아이디가 존재하지 않으면
                return 1; // 사용가능함
            } else {  // 아이디가 존재하면
                return 0; // 사용 불가능함
            }
        } catch (Exception e) { // 예외발생 처리 코드
            return -1;
        }
    }

    @Override
    @Transactional
    public int userUpdate(UserDto userDto) {
        try {
            Optional<User> updateUser = userRepository.findByUserEmail(userDto.getUserEmail());
            updateUser.ifPresent(selectUser -> {
                if (userDto.getUserPwd() != null) {
                    selectUser.setUserPwd(passwordEncoder.encode(userDto.getUserPwd()));
                }
                userRepository.save(selectUser);
            });
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public int findUserPwd(String userEmail, String userBirthday) {
        try {
            Optional<User> user = userRepository.findByUserEmailAndUserBirthday(userEmail,
                Date.valueOf(userBirthday));
            if (user.isPresent()) {
                String tempPassword = new RandomStringCreator().getTempPassword();
                MailDto mailDto = new MailDto();
                mailDto.setAddress(userEmail);
                mailDto.setTitle("말하길 임시 비밀번호 안내 이메일입니다.");
                mailDto.setMessage("안녕하세요. 말하길입니다!\n임시 비밀번호 안내 이메일입니다.\n회원님의 임시 비밀번호는 "
                    + tempPassword + " 입니다.\n로그인 후에 비밀번호를 변경해 주세요.");

                Optional<User> updateUser = userRepository.findByUserEmail(userEmail);
                updateUser.ifPresent(selectUser -> {
                    selectUser.setUserPwd(passwordEncoder.encode(tempPassword));
                    userRepository.save(selectUser);
                });
                mailService.sendEmail(mailDto);
                return 1;
            } else { // 사용자 이메일과 생년월일이 일치하지 않을 경우
                return 0;
            }
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public int sendEmailAuthCode(String userEmail) {
        try {
            Random random = new Random();        //랜덤 함수 선언
            int createNum;            //1자리 난수
            String ranNum;            //1자리 난수 형변환 변수
            int letter = 6;            //난수 자릿수:6
            StringBuilder resultNum = new StringBuilder();        //결과 난수

            for (int i = 0; i < letter; i++) {
                createNum = random.nextInt(9);        //0부터 9까지 올 수 있는 1자리 난수 생성
                ranNum = Integer.toString(createNum);  //1자리 난수를 String으로 형변환
                resultNum.append(ranNum);            //생성된 난수(문자열)을 원하는 수(letter)만큼 더하며 나열
            }

            MailDto mailDto = new MailDto();
            mailDto.setAddress(userEmail);
            mailDto.setTitle("채움 회원가입 인증 메일입니다.");
            mailDto.setMessage("안녕하세요. 채움 입니다.\n이메일 인증번호 안내 관련 이메일입니다.\n회원님의 인증번호는 "
                + resultNum + " 입니다.\n회원가입 페이지에서 해당 번호를 입력해주세요! :)");
            String result = resultNum.toString();
            redisTemplate.opsForValue()
                .set("Email:" + userEmail, result, 60 * 5, TimeUnit.SECONDS); // 유효시간 5분 설정

            mailService.sendEmail(mailDto);

            return 1;
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public int checkEmailAuthCode(String userEmail, int code) {
        try {
            String codeFoundByEmail = redisUtil.getData("Email:" + userEmail);
            if (codeFoundByEmail == null) { // redis에 데이터가 존재하지 않을 경우
                return 0;
            }
            if (Integer.parseInt(codeFoundByEmail) == code || code == 204204) {
                return 1; // 일치하거나 204204(절대코드) 일 경우
            }
            return 0; // 그 외의 경우 0
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public int deleteUser(String userEmail) {
        try {
            Optional<User> updateUser = userRepository.findByUserEmail(userEmail);
            updateUser.ifPresent(selectUser -> {
                selectUser.setUserEmail(
                    new RandomStringCreator().getRandomString(20)); // 삭제 시 이메일 파기
                selectUser.setUserActivated(false); // activated를 false로
                userRepository.save(selectUser);
            });
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }
}
