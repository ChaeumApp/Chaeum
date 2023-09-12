package com.tls.Item.entity.single;

import com.tls.Ingredient.entity.single.Ingredient;
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
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "item_tb")
@DynamicInsert
public class Item {

    @Id
    @Column(name = "item_id")
    private long item_id;

    @Column(name = "item_name")
    private String item_name;

    @Column(name = "item_image")
    private String item_image;

    @Column(name = "item_price")
    private int item_price;

    @Column(name = "item_store")
    private String itemStore;

    @Column(name = "item_storelink")
    private String itemStoreLink;

    @ManyToOne
    @JoinColumn(name = "ingredient_tb")
    private Ingredient ingredient;
}
