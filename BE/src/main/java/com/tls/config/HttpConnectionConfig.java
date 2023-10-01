package com.tls.config;

import java.net.HttpURLConnection;
import java.net.URL;

public class HttpConnectionConfig {
    public static int callDjangoConn(int userId) {
        try {
            URL url = new URL("https://j9c204.p.ssafy.io:8000/recommend/" +userId);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();

            conn.setRequestMethod("GET"); // http 메서드
            conn.setRequestProperty("Content-Type", "application/json"); // header Content-Type 정보
            conn.setRequestProperty("auth", "myAuth"); // header의 auth 정보
            conn.setDoOutput(false); // 서버로부터 받는 값이 있다면 true
            return conn.getResponseCode();

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
}
