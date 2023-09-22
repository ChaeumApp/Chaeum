package com.tls.user.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserSignInVO {
    String userEmail;
    String userPwd;
    String notiToken;
}
