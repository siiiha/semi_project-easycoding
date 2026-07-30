package com.semi.easycoding.Batch;

import com.semi.easycoding.Batch.service.BatchService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class EduGenerationScheduler {

    private final BatchService batchService;

    public EduGenerationScheduler(BatchService batchService) {
        this.batchService = batchService;
    }


    // 매일 특정 시간에 실행되는 설정 : "0 분 시 * * *"
    // 매 시, n분 마다 반복하는 설정 : "0 /분 * * * *"
    @Scheduled(cron = "0 0 15 * * *", zone = "Asia/Seoul")
    public void generateEducationsOption() {
        batchService.generateEducationsOption(3); // 1회 실행
    }
}
