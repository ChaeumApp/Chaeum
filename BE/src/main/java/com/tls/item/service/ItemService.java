package com.tls.item.service;

import com.tls.item.dto.ItemDto;
import com.tls.item.vo.ItemVO;
import java.util.List;

public interface ItemService {

    List<ItemDto> getItems(int ingrId);

    List<ItemDto> getTodaysBestItems();

    ItemDto viewItem(long itemId);

    int dislikeItem(ItemVO itemVO);

    int selectItem(ItemVO itemVO);

}
