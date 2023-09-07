package com.tls.user.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

@Entity
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
@Table(name = "user_tb")
@DynamicInsert
public class User {

    @Id
    @Column(name = "user_id")
    private int userId;

    @Column(name = "user_email", nullable = false)
    private String userEmail;

    @Column(name = "user_pwd", nullable = false)
    private String userPwd;

    @Column(name = "user_birthday", nullable = false)
    private Date userBirthday;

    @Column(name = "user_gender", nullable = false)
    private String userGender;

    @Column(name = "user_activated", nullable = false)
    private boolean userActivated;

    @ManyToOne
    @JoinColumn(name = "vegan_id")
    private Vegan vegan;
}
