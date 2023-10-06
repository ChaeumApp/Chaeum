package com.tls.search.service;

import com.tls.search.dto.SearchDto;

public interface SearchService {
    SearchDto searchQuery(String query);
}
