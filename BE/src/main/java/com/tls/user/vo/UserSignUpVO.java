package com.tls.user.vo;

import com.tls.allergy.single.Allergy;
import java.util.Date;
import java.util.List;
import lombok.Data;

@Data
public class UserSignUpVO {
    Date userBirthday;
    String userEmail;
    String userGender;
    String userPwd;
    int veganId;
    List<Allergy> allergyList;
    String notiToken;
}
