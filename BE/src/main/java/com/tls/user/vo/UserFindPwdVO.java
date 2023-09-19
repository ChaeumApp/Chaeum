package com.tls.user.vo;

import java.util.Date;
import lombok.Data;

@Data
public class UserFindPwdVO {

    String userEmail;
    Date userBirthday;
}
