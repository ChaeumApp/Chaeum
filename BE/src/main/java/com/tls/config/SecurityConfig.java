package com.tls.config;


import com.tls.jwt.JwtAuthenticationFilter;
import com.tls.jwt.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtTokenProvider jwtTokenProvider;
    private final StringRedisTemplate stringRedisTemplate;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .httpBasic().disable()
            .csrf().disable()
            .sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS) // sessiond 을 쓰지 않는다는 말
            .and()
            .authorizeRequests()
            .antMatchers("/v3/api-docs", "/swagger*/**").permitAll() // swagger 관련 permit all
            .antMatchers("/user/**").permitAll()
            .antMatchers("/category/**").permitAll()
            .antMatchers("/", "/static/**", "/assets/**").permitAll()
            .antMatchers("/**").permitAll()
            .antMatchers("/favicon.ico").permitAll()
            .antMatchers("/manifest.json").permitAll()
            .anyRequest().authenticated() // 이 밖의 모든 요청에 대해 인증을 필요로 한다는 설정

            .and() // filter 설정하여
            .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider, stringRedisTemplate),
                UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public PasswordEncoder getPasswordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

}
