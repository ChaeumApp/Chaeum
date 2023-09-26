package com.tls.ingredient.entity.single;

import java.time.LocalDate;
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

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "ingredient_price_tb")
public class IngredientPrice {

    @Id
    @Column(name = "ingr_price_id")
    private int ingrPricePk;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingr_id")
    private Ingredient ingrId;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "price")
    private int price;
}
