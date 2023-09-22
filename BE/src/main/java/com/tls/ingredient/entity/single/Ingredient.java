package com.tls.ingredient.entity.single;

import com.tls.category.entity.Category;
import com.tls.category.entity.SubCategory;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

@Entity
@Getter
@NoArgsConstructor
@Builder
@AllArgsConstructor
@Table(name = "ingredient_tb")
@DynamicInsert
public class Ingredient {

    @Id
    @Column(name = "ingr_id")
    private int ingrId;

    @Column(name = "ingr_name")
    private String ingrName;

    @ManyToOne
    @JoinColumn(name = "subcat_id")
    private SubCategory subCategory;

    @ManyToOne
    @JoinColumn(name = "cat_id")
    private Category category;
}
