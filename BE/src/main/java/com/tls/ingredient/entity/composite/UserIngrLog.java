package com.tls.ingredient.entity.composite;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.user.entity.User;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "ingredient_select_log_tb")
public class UserIngrLog {

    @Id
    @Column(name = "ingr_select_pk")
    private int ingrSelectPk;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User userId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingr_id")
    private Ingredient ingrId;

    @CreationTimestamp
    @Column(name = "ingr_select_time")
    private LocalDateTime itemSelectTime;

}
