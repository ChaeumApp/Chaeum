package com.tls.item.repository;

import com.tls.item.entity.single.Item;
import org.springframework.data.repository.Repository;

public interface ItemRepository extends Repository<Item, String> {
    void save(Item item);
}
