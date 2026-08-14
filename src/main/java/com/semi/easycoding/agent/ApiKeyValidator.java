package com.semi.easycoding.agent;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.HttpURLConnection;
import java.net.URL;


// todo 서비스로 빼야함
@Component
public class ApiKeyValidator {

    public boolean isValidOpenAiKey(String apiKey) {
        // API 키 유효성을 검사합니다
        // OpenAI API에 요청을 보내서 유효성을 확인받습니다
        try {
            URL url = new URL("https://api.openai.com/v1/models");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Authorization", "Bearer " + apiKey);
            connection.setConnectTimeout(3000);

            int responseCode = connection.getResponseCode();

            return responseCode == 200;

        } catch (Exception e) {
            return false;
        }
    }
}
