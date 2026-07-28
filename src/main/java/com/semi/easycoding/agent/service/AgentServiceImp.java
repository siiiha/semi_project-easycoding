package com.semi.easycoding.agent.service;


import com.semi.easycoding.education.dto.EducationBlankTypeDto;
import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.EducationOptionTypeDto;
import com.semi.easycoding.education.dto.OptionDto;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;

@Service
public class AgentServiceImp implements AgentService {

    private final ChatClient chatClient;

    @Value("classpath:prompts/system-prompt-optional.st")
    Resource optionalSystemPromptFile;
    @Value("classpath:prompts/system-prompt-blank.st")
    Resource blankSystemPromptFile;

    private String SystemPrompt;

    public AgentServiceImp(ChatClient.Builder builder){
        this.chatClient = builder.build();
    }

    private String requestToAgent(String requestMsg){
        return chatClient.prompt()
                .system(SystemPrompt)
                .user(requestMsg)
                .call()
                .content();
    }

    @Override
    public String requestBlank(String requestMsg){
        try {
            SystemPrompt = blankSystemPromptFile.getContentAsString(StandardCharsets.UTF_8);
        } catch (Exception e) {
            return "Error";
        }
        return requestToAgent(requestMsg);
    }

    @Override
    public String requestOptional(String requestMsg){
        try {
            SystemPrompt = optionalSystemPromptFile.getContentAsString(StandardCharsets.UTF_8);
        } catch (Exception e) {
            return "Error";
        }
        return requestToAgent(requestMsg);
    }

    @Override
    public EducationDto stringToEducationDto(String json) {
        // json 문자열을 EducationDto 객체로 변환하는 로직
        // ObjectMapper objectMapper = new ObjectMapper();
        ObjectMapper om = new ObjectMapper();
        JsonNode rootNode = om.readTree(json);
        LocalDateTime now = LocalDateTime.now();
        EducationDto myDto;

        if(rootNode.path("educationType").asInt() == 1){
            myDto = om.readValue(json, EducationOptionTypeDto.class);
            myDto.setCreatedAt(now);
        }
        else if(rootNode.path("educationType").asInt() == 2){
            //todo : 빈칸채우기 문제 생성시 EducationBlankTypeDto로 변환
            myDto = null;
        }
        else {
            myDto = null;
        }

        return myDto;
    }
}
