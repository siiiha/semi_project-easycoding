package com.semi.easycoding.batch.service;

import com.semi.easycoding.agent.service.AgentService;
import org.springframework.stereotype.Service;

@Service
public class BatchServiceImp extends Thread implements BatchService {

    private final AgentService agentService;

    public BatchServiceImp(AgentService agentService) {
        this.agentService = agentService;
    }

    // times 만큼 모든 카테고리의 객관식 문제 1회씩 생성
    @Override
    public void generateEducationsOption(int times) {
        for (int i = 0; i < times; i++) {
            agentService.generationAllEducationOption();
        }
    }
}
