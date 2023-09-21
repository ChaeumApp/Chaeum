package com.tls.allergy.composite;

import com.tls.ingredient.entity.single.Ingredient;
import com.tls.allergy.id.AllergyIngredientId;
import com.tls.allergy.single.Allergy;
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
@Table(name = "allergy_ingredient_tb")
@IdClass(AllergyIngredientId.class)
public class AllergyIngredient {

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "algy_Id")
    private Allergy algyId;

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingr_id")
    private Ingredient ingrId;
}
