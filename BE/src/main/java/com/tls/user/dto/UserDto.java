package com.tls.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {

    private String userEmail;
    private String userPwd;
    private String userBirthday;
    private String userGender;
    private boolean userActivated;
    private int veganId;
}
