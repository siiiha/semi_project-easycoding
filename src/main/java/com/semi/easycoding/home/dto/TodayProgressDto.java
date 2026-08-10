package com.semi.easycoding.home.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// main_user.jsp에 오늘의 학습 진행 데이터를 전달하기 위한 DTO
@Getter
@NoArgsConstructor
@Setter

public class TodayProgressDto {

    private int done;
    private int total;

    public int getPercent() {
        return total == 0 ? 0 : done * 100 / total;
    }
}
