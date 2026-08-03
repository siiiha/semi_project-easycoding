package com.semi.easycoding.agent.service;

import com.semi.easycoding.education.dto.EducationDto;

public interface AgentService {

    String requestBlank(String requestMsg);

    String requestOptional(String requestMsg);

    EducationDto stringToEducationDto(String json);

    int generationAllEducationOption();

}
