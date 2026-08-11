package com.semi.easycoding.home.service;

import com.semi.easycoding.home.dto.GrassMonthDto;
import com.semi.easycoding.home.dto.LearningStatsDto;
import com.semi.easycoding.home.dto.TodayProgressDto;
import java.util.List;

public interface HomeDashboardService {

    // 선택한 문제 수와 카테고리에 따라 회원의 오늘 학습 문제를 준비한다.
    void prepareDailyQuiz(Long memberId, int problemCount, Short categoryId);

    // 오늘 배정된 전체 문제 수와 완료 문제 수를 조회한다.
    TodayProgressDto getTodayProgress(Long memberId);

    // 현재 달을 포함한 최근 3개월의 월별 학습 잔디 상태를 조회한다.
    List<GrassMonthDto> getGrassMonths(Long memberId);

    // 연속 학습 일수, 총 완료 문제 수, 정답률을 조회한다.
    LearningStatsDto getLearningStats(Long memberId);
}
