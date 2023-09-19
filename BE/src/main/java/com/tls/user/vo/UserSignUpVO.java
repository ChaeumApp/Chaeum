package com.tls.user.vo;

import java.util.Date;
import lombok.Data;

@Data
public class UserSignUpVO {
    Date userBirthday;
    String userEmail;
    String userGender;
    String userPwd;
    int veganId;
}
