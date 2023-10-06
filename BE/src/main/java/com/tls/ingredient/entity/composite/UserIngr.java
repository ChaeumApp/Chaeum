package com.tls.ingredient.entity.composite;

import com.tls.ingredient.entity.id.UserIngrId;
import com.tls.ingredient.entity.single.Ingredient;
import com.tls.user.entity.User;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "saved_ingredient_tb")
@IdClass(UserIngrId.class)
public class UserIngr {

    @Id
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User userId;

    @Id
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ingr_id")
    private Ingredient ingrId;
}
