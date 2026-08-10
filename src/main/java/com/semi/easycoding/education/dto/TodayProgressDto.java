package com.semi.easycoding.education.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

// main_user.jsp에 오늘의 학습 진행 데이터를 전달하기 위한 DTO
@Getter
@AllArgsConstructor
public class TodayProgressDto {

    private final int done;
    private final int total;

    public int getPercent() {
        return total == 0 ? 0 : done * 100 / total;
    }
}
