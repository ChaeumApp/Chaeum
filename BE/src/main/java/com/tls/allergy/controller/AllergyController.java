package com.tls.allergy.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Tag(name = "알러지 API", description = "알러지 관련 API 입니다.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/allergy")
public class AllergyController {

//    private final AllergyService allergyService;
}
