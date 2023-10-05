package com.tls.config;

import java.net.HttpURLConnection;
import java.net.URL;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class HttpConnectionConfig {
    public static void callDjangoConn(int userId) {
        log.info("{} django call ::", userId);
        // 새로운 스레드 생성
        Thread thread = new Thread(() -> {
            try {
                log.info("Thread created");
                URL url = new URL("http://j9c204.p.ssafy.io:8000/recommend/" + userId);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();

                conn.setRequestMethod("GET"); // http 메서드
                conn.setRequestProperty("Content-Type", "application/json"); // header Content-Type 정보
                conn.setRequestProperty("auth", "myAuth"); // header의 auth 정보
                conn.setDoOutput(true); // 서버로부터 받는 값이 있다면 true
                int resultCode = conn.getResponseCode();  // 요청 보내기
                log.info("{} django call :: response code : {}", userId, resultCode);
            } catch (Exception e) {
                log.warn("error while sending django API");
                e.printStackTrace();
            }
        });

        thread.start();  // 스레드 시작
    }
}