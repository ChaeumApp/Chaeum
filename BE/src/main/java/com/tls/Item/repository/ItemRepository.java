package com.tls.Item.repository;

import com.tls.Item.entity.single.Item;
import org.springframework.data.repository.Repository;

public interface ItemRepository extends Repository<Item, String> {
    void save(Item item);
}
