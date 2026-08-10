package com.semi.easycoding.home.dto;
//로그인 홈 화면 오른쪽에 표시되는 학습 통계 3개를 전달하기 위한 DTO
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class LearningStatsDto {

    private int streak; //연속 학습 일수
    private int totalSolved;    //지금까지 완료한 문제 수
    private double correctRate; //완료한 문제 중 정답 비율
}