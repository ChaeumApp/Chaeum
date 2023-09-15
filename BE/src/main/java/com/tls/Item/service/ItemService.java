package com.tls.Item.service;

import com.tls.Item.dto.ItemDto;
import com.tls.Item.vo.ItemVO;
import java.util.List;

public interface ItemService {

    List<ItemDto> getItems(int ingrId);

    List<ItemDto> getTodaysBestItems();

    ItemDto viewItem(long itemId);

    int dislikeItem(ItemVO itemVO);

    int selectItem(ItemVO itemVO);

}
