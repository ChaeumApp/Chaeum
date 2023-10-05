package com.tls.config;

import java.net.HttpURLConnection;
import java.net.URL;

public class HttpConnectionConfig {
    public static void callDjangoConn(int userId) {
        // 새로운 스레드 생성
        Thread thread = new Thread(() -> {
            try {
                URL url = new URL("http://j9c204.p.ssafy.io:8000/recommend/" + userId);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();

                conn.setRequestMethod("GET"); // http 메서드
                conn.setRequestProperty("Content-Type", "application/json"); // header Content-Type 정보
                conn.setRequestProperty("auth", "myAuth"); // header의 auth 정보
                conn.setDoOutput(false); // 서버로부터 받는 값이 있다면 true
                conn.getResponseCode();  // 요청 보내기

            } catch (Exception e) {
                e.printStackTrace();
            }
        });

        thread.start();  // 스레드 시작
    }
}