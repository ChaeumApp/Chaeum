package com.tls.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {
    private int userId;
    private String userEmail;
    private String userPwd;
    private String userBirthday;
    private String userGender;
    private Boolean userActivated;
    private int veganId;
}
