package com.semi.easycoding.home.service;

import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.service.EducationService;
import com.semi.easycoding.home.dto.GrassCellDto;
import com.semi.easycoding.home.dto.LearningStatsDto;
import com.semi.easycoding.home.dto.TodayProgressDto;
import com.semi.easycoding.home.mapper.HomeDashboardMapper;
import java.util.List;
import java.util.Set;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class HomeDashboardServiceImpl implements HomeDashboardService {

    private static final Set<Integer> ALLOWED_PROBLEM_COUNTS =
            Set.of(3, 5, 10, 20);

    private final EducationService educationService;
    private final HomeDashboardMapper homeDashboardMapper;

    public HomeDashboardServiceImpl(
            EducationService educationService,
            HomeDashboardMapper homeDashboardMapper) {
        this.educationService = educationService;
        this.homeDashboardMapper = homeDashboardMapper;
    }

    @Transactional
    @Override
    public void prepareDailyQuiz(
            Long memberId,
            int problemCount,
            Short categoryId
    ) {
        if (!ALLOWED_PROBLEM_COUNTS.contains(problemCount)) {
            throw new IllegalArgumentException("허용되지 않은 문제 수입니다.");
        }

        if (!educationService.memberTodayEducationIsEmpty(memberId)) {
            return;
        }

        List<EducationDto> educations;
        if (categoryId == null) {
            educations = educationService.notAssignedEducations(memberId, problemCount);
            //전체 선택을 한 경우
        } else {
            educations = educationService.notAssignedEducations(memberId, problemCount, categoryId);
        }

        educationService.assignEducation(memberId, educations);
        //가져온 문제를 오늘 문제로 DB에 저장한다.
    }

    //오늘 배정된 문제를 조회한 뒤, 전체 문제 수와 답변 완료 수를 계산하여 반환
    // 오늘 배정된 전체 문제 수와 완료 문제 수를 조회한다
    @Override
    public TodayProgressDto getTodayProgress(Long memberId) {
        return homeDashboardMapper.selectTodayProgress(memberId);
    }

    // 최근 105일의 날짜별 학습 잔디 상태를 조회한다
    @Override
    public List<GrassCellDto> getGrassCells(Long memberId) {
        return homeDashboardMapper.selectGrassCells(memberId);
    }

    // 지금까지의 연속 학습 일수, 총 완료 문제 수, 정답률을 조회한다
    @Override
    public LearningStatsDto getLearningStats(Long memberId) {
        LearningStatsDto learningStats =
                homeDashboardMapper.selectLearningStats(memberId);

        learningStats.setStreak(educationService.countStreakDay(memberId));
        return learningStats;
    }
}
