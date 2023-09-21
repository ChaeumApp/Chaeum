package com.tls.item.service;

import com.tls.ingredient.repository.IngrRepository;
import com.tls.item.converter.ItemConverter;
import com.tls.item.dto.ItemDto;
import com.tls.item.entity.composite.UserItemLog;
import com.tls.item.repository.ItemRepository;
import com.tls.item.repository.UserItemLogRepository;
import com.tls.item.vo.ItemVO;
import com.tls.user.repository.UserRepository;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ItemServiceImpl implements ItemService {

    private final ItemRepository itemRepository;
    private final IngrRepository ingrRepository;
    private final UserRepository userRepository;
    private final UserItemLogRepository userItemLogRepository;
    private final ItemConverter itemConverter = new ItemConverter();

    @Override
    public List<ItemDto> getItems(int ingrId) {
        try {
            List<ItemDto> results = new ArrayList<>();
            itemRepository.findByIngredient(ingrRepository.findByIngrId(ingrId).orElseThrow())
                .orElseThrow().forEach(item ->
                    results.add(itemConverter.entityToDto(item))
                );
            return results;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<ItemDto> getTodaysBestItems() {
        return null;
    }

    @Override
    public int dislikeItem(String userEmail, ItemVO itemVO) {
        return 0;
    }

    @Override
    public ItemDto viewItem(long itemId) {
        try {
            return itemConverter.entityToDto(itemRepository.findByItemId(itemId).orElseThrow());
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public int selectItem(String userEmail, ItemVO itemVO) {
        try {
            UserItemLog userItemLog = UserItemLog.builder()
                .userId(userRepository.findByUserEmail(userEmail).orElseThrow())
                .itemId(itemRepository.findByItemId(itemVO.getItemId()).orElseThrow())
                .build();
            userItemLogRepository.save(userItemLog);
            return 1;
        } catch (Exception e) {
            return -1;
        }
    }
}
