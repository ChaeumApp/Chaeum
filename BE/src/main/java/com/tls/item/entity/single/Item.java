package com.tls.item.entity.single;

import com.tls.ingredient.entity.single.Ingredient;
import java.time.LocalDate;
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
    private String itemId;

    @Column(name = "item_name")
    private String itemName;

    @Column(name = "item_image")
    private String itemImage;

    @Column(name = "item_price")
    private int itemPrice;

    @Column(name = "item_store")
    private String itemStore;

    @Column(name = "item_storelink")
    private String itemStoreLink;

    @ManyToOne
    @JoinColumn(name = "ingr_id")
    private Ingredient ingredient;

    @Column(name = "item_crawling_date", nullable = false)
    private LocalDate itemCrawlingDate;
}
