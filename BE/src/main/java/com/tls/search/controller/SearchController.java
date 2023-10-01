package com.tls.search.controller;

import com.tls.search.dto.SearchDto;
import com.tls.search.service.SearchService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@Tag(name = "검색 API", description = "식재료/레시피 검색 관련 API 입니다.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/search")
public class SearchController {

    private final SearchService searchService;

    @GetMapping()
    @Operation(summary = "소분류/레시피 조회 메서드", description = "검색어로 소분류/레시피를 조회하는 메서드입니다.", tags = "검색 API")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "검색 성공하면 ok를, 실패하면 fail을 반환한다.")
    })
    public ResponseEntity<?> searchQuery(@RequestParam String query) {
        SearchDto result = searchService.searchQuery(query);
        if (result != null) {
            return new ResponseEntity<>(result, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("fail", HttpStatus.OK);
        }
    }
}
