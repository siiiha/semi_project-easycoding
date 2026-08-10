package com.semi.easycoding.home.service;

import com.semi.easycoding.education.dto.TodayProgressDto;

public interface HomeDashboardService {

    // 선택한 문제 수와 카테고리에 따라 회원의 오늘 학습 문제를 준비한다
    void prepareDailyQuiz(Long memberId, int problemCount, Long categoryId);
    //전체 문제 수, 완료한 문제 수, 진행률을 조회. TodayProgressDto로 반환하는것이 필요하다고 선언
    TodayProgressDto getTodayProgress(Long memberId);
}