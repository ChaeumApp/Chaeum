package com.tls.item.entity.composite;

import com.tls.item.entity.single.Item;
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
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "item_purchased_log_tb")
public class ItemPurchaseLog {

    @Id
    @Column(name = "item_purchased_log_pk")
    private long itemPurchasedLogPk;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User userId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id")
    private Item itemId;

    @CreationTimestamp
    @Column(name = "item_purchased_time")
    private LocalDateTime itemPurchasedTime;
}
