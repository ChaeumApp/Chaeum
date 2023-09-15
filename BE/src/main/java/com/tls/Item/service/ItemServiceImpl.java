package com.tls.Item.service;

import com.tls.Item.dto.ItemDto;
import com.tls.Item.vo.ItemVO;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class ItemServiceImpl implements ItemService {

    @Override
    public List<ItemDto> getItems(int ingrId) {
        return null;
    }

    @Override
    public List<ItemDto> getTodaysBestItems() {
        return null;
    }

    @Override
    public int dislikeItem(ItemVO itemVO) {
        return 0;
    }

    @Override
    public ItemDto viewItem(long itemId) {
        return null;
    }

    @Override
    public int selectItem(ItemVO itemVO) {
        return 0;
    }
}
