package com.tls.ingredient.entity.composite;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.user.entity.User;
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

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "ingredient_preference_tb")
public class IngredientPreference {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ingr_pref_pk")
    private int id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "ingr_id", nullable = false)
    private Ingredient ingredient;

    @Column(name = "pref_rating")
    private double prefRating;

    public void updatePrefRating(double prefRating){
        this.prefRating = prefRating;
    }

}