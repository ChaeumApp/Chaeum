package com.tls.user.entity;

import java.util.Collection;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Getter
@NoArgsConstructor
@Builder
@AllArgsConstructor
@Table(name = "user_tb")
@DynamicInsert
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private int userId;

    @Column(name = "user_email")
    private String userEmail;

    @Column(name = "user_pwd", nullable = false)
    private String userPwd;

    @Column(name = "user_birthday", nullable = false)
    private Date userBirthday;

    @Column(name = "user_gender", nullable = false)
    private String userGender;

    @Column(name = "user_activated", nullable = false)
    private Boolean userActivated;

    @ManyToOne
    @JoinColumn(name = "vegan_id")
    private Vegan vegan;

    @Override
    public String toString() {
        return "User{" +
            "userId=" + userId +
            ", userEmail='" + userEmail + '\'' +
            ", userPwd='" + userPwd + '\'' +
            ", userBirthday=" + userBirthday +
            ", userGender='" + userGender + '\'' +
            ", userActivated=" + userActivated +
            ", vegan=" + vegan +
            '}';
    }

    public void updateUserPwd(String newUserPwd) {
        this.userPwd = newUserPwd;
    }

    public void deactivateUser() {
        this.userEmail = null;
        this.userActivated = false;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return this.userPwd;
    }

    @Override
    public String getUsername() {
        return this.userEmail;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
