package com.semi.easycoding.agent.controllter;

import com.semi.easycoding.agent.ApiKeyValidator;
import com.semi.easycoding.agent.service.AgentServiceImp;
import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.service.EducationService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AgentController {

    private final ApiKeyValidator apiChecker;
    private final AgentServiceImp agentService;
    private final EducationService educationService;

    public AgentController(ApiKeyValidator apiChecker,
                           AgentServiceImp agentService,
                           EducationService educationService) {
        this.apiChecker = apiChecker;
        this.agentService = agentService;
        this.educationService = educationService;
    }

    @Value("${spring.ai.openai.api-key}")
    String apiKey;

    @GetMapping("/test/agent/create")
    @ResponseBody
    String createEducations(@RequestParam int type, @RequestParam String topic){
        // 직접 문제 생성 요청 메서드
        // 전달자로 type(1: 객관식, 2: 빈칸채우기), topic(문제 주제)을 받음
        // 실행되면 API키의 유효성을 먼저 판별, 이후 LLM Agent에게 문제생성 요청후 반환
        // json 타입으로 받음(Service쪽에서 구현하는것이 올바름)

        if(!apiChecker.isValidOpenAiKey(apiKey)){
            return "APIKey Error";
        }
        String json;
        EducationDto dto;

        switch (type){
            // 1은 객관식 생성
            case 1:
                json = agentService.requestOptional(topic);
                dto = agentService.stringToEducationDto(json);
                educationService.storeEducation(dto);
                return "good";
            // 2는 빈칸채우기 생성
            case 2:
                json = agentService.requestBlank(topic);
                dto = agentService.stringToEducationDto(json);
                educationService.storeEducation(dto);
                return "good";
        }

        return "type Error";
    }

    @GetMapping("/test/agent/createall")
    @ResponseBody
    int createEducationsAll(){
        return agentService.generationAllEducationOption();
    }


    EducationDto[] educationMapping(String response){
        return null;
    }
    // 전달받은 데이터를 가공해 EducationDto[]로 변환 후 반환

}
