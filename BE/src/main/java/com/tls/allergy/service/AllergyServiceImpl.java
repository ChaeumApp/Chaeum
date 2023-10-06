package com.tls.allergy.service;

import com.tls.allergy.entity.composite.UserAllergy;
import com.tls.allergy.repository.AllergyRepository;
import com.tls.allergy.repository.UserAllergyRepository;
import com.tls.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AllergyServiceImpl implements AllergyService {

    private final UserRepository userRepository;
    private final AllergyRepository allergyRepository;
    private final UserAllergyRepository userAllergyRepository;
    @Override
    public int addUserAllergy(String userEmail, int algyId) {
        try {
            // 기존에 있는지 확인
            UserAllergy userAllergy = UserAllergy.builder()
                .userId(userRepository.findByUserEmail(userEmail).orElse(null))
                .algyId(allergyRepository.findByAlgyId(algyId).orElse(null))
                .build();
        } catch (Exception e) {
            return 406;
        }
        return 200;
    }
}
