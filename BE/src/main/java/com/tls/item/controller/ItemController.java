package com.tls.item.controller;

import com.tls.item.dto.ItemDto;
import com.tls.item.service.ItemService;
import com.tls.item.vo.ItemVO;
import com.tls.jwt.JwtTokenProvider;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@Tag(name = "상품 API", description = "상품 관련 API 입니다.")
@RequiredArgsConstructor
@RequestMapping("/item")
public class ItemController {

    private final ItemService itemService;
    private final JwtTokenProvider jwtTokenProvider;

    @GetMapping("/detail/{itemId}")
    @Operation(summary = "상품 상세 조회 메서드", description = "상품 번호에 대한 상세 조회", tags = "상품 API")
    @ApiResponse(responseCode = "200", description = "상품 상세 조회 시 해당 상품 정보를 반환한다.\n"
        + "해당 상품 번호가 없을 경우 fail 을 반환한다.")
    public ResponseEntity<?> viewItem(@PathVariable("itemId") long itemId) {
        ItemDto itemDto = itemService.viewItem(itemId);
        if (itemDto != null) {
            return new ResponseEntity<>(itemDto, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/{ingrId}")
    @Operation(summary = "소분류 ID로 상품 조회 메서드", description = "소분류 ID로 상품을 조회한다.", tags = "상품 API")
    @ApiResponse(responseCode = "200", description = "소분류별 상품 조회 시 해당 상품의 리스트를 반환한다.\n"
        + "해당 식재료 ID가 없을 경우 fail 을 반환한다.")
    public ResponseEntity<?> getItems(@PathVariable("ingrId") int ingrId) {
        List<ItemDto> itemDtoList = itemService.getItems(ingrId);
        if (itemDtoList != null) {
            return new ResponseEntity<>(itemDtoList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @GetMapping("/best")
    @Operation(summary = "오늘의 채움 베스트 상품 조회 메서드", description = "오늘의 채움 베스트 상품을 조회합니다.", tags = "상품 API")
    @ApiResponse(responseCode = "200", description = "채움 베스트 상품을 조회 성공 시 상품 리스트를 반환한다.\n"
        + "실패 시 fail 을 반환한다.")
    public ResponseEntity<?> getTodaysBestItems() {
        log.info("getTodaysBestItems call :: ");
        List<ItemDto> itemDtoList = itemService.getBestItems();
        if (itemDtoList != null) {
            return new ResponseEntity<>(itemDtoList, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/dislike")
    @Operation(summary = "상품 관심없음 반영 메서드",
        description = "사용자가 특정 상품을 관심없음 설정한 내용을 저장합니다.", tags = "상품 API")
    @ApiResponse(responseCode = "200", description = "관심없음 설정 반영 성공 시 success 를 반환한다.\n"
        + "관심없음 설정 반영 실패 시 fail 을 반환한다.")
    public ResponseEntity<?> dislikeItem(@RequestHeader("Authorization") String tokenWithPrefix, @RequestBody ItemVO itemVO) {
        log.info("dislikeItem call :: ");
        Authentication authentication = jwtTokenProvider.getAuthentication(
            tokenWithPrefix.substring(7));
        int n = itemService.dislikeItem(authentication.getName(), itemVO);
        if (n == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/selected")
    @Operation(summary = "상품 선택 반영 메서드", description = "사용자가 특정 상품을 선택한 내용을 저장합니다.", tags = "상품 API")
    public ResponseEntity<?> selectItem(@RequestHeader("Authorization") String tokenWithPrefix, @RequestBody ItemVO itemVO) {
        log.info("selectItem call :: ");
        Authentication authentication = jwtTokenProvider.getAuthentication(
            tokenWithPrefix.substring(7));
        int n = itemService.selectItem(authentication.getName(), itemVO);
        if (n == 1) {
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

    @PostMapping("/purchased")
    @Operation(summary = "상품 구매 후 호출 메서드", description = "사용자의 상품 구매 내역을 저장한다.", tags = "상품 API")
    public ResponseEntity<?> purchaseItem(@RequestHeader("Authorization") String tokenWithPrefix, @RequestBody ItemVO itemVO) {
        try{
            Authentication authentication = jwtTokenProvider.getAuthentication(
                tokenWithPrefix.substring(7));
            log.info("purchased Item call :: {} {}", authentication.getName(), itemVO.getItemId());
            int n = itemService.purchaseItem(authentication.getName(), itemVO);
            if (n == 1) {
                return new ResponseEntity<>("success", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("fail", HttpStatus.OK);
            }
        } catch (Exception e){
            log.warn("User authentication failed");
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }

}
