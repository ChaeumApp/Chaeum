package com.tls.user.service;

import com.tls.user.entity.User;
import com.tls.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String userEmail) throws UsernameNotFoundException {
        return userRepository.findByUserEmail(userEmail)
            .map(this::createUserDetails)
            .orElseThrow(() -> new UsernameNotFoundException(("해당하는 유저를 찾을 수 없습니다.")));
    }

    private UserDetails createUserDetails(User user) {

        return User.builder()
            .userEmail(user.getUserEmail())
            .userPwd(user.getUserPwd())
            .build();
    }
}
