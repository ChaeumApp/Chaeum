package com.tls.ingredient.entity.composite;

import com.tls.ingredient.entity.single.Ingredient;
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
@Table(name = "ingredient_default_preference_tb")
public class IngredientDefaultPreference {

    @Id
    @Column(name = "ingr_default_pref_id")
    private int id;

    @Column(name = "group_id", nullable = false)
    private int groupId;

    @ManyToOne
    @JoinColumn(name = "ingr_id", nullable = false)
    private Ingredient ingredient;

    @Column(name = "pref_rating")
    private double prefRating;
}
