package com.tls.item.repository;

import com.tls.item.entity.composite.UserItemLog;
import com.tls.item.entity.single.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserItemLogRepository extends JpaRepository<UserItemLog, Long> {

    @Query("SELECT uil.itemId " +
            "FROM UserItemLog uil " +
            "WHERE FUNCTION('DATE', uil.itemSelectTime) = FUNCTION('CURRENT_DATE') " +
            "GROUP BY uil.itemId " +
            "ORDER BY COUNT(uil) DESC")
    List<Item> findBestItems();
}
