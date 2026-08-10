package com.semi.easycoding.home.service;

import com.semi.easycoding.home.dto.GrassCellDto;
import com.semi.easycoding.home.dto.TodayProgressDto;
import com.semi.easycoding.home.dto.LearningStatsDto;
import java.util.List;

public interface HomeDashboardService {

    // 선택한 문제 수와 카테고리에 따라 회원의 오늘 학습 문제를 준비한다
    void prepareDailyQuiz(Long memberId, int problemCount, Short categoryId);
    //전체 문제 수, 완료한 문제 수, 진행률을 조회. TodayProgressDto로 반환하는것이 필요하다고 선언
    TodayProgressDto getTodayProgress(Long memberId);
    List<GrassCellDto> getGrassCells(Long memberId);
    LearningStatsDto getLearningStats(Long memberId);
}