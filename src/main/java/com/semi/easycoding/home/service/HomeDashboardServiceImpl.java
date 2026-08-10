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
    public void prepareDailyQuiz(Long memberId, int problemCount, Long categoryId) {
        if (!ALLOWED_PROBLEM_COUNTS.contains(problemCount)) {
            throw new IllegalArgumentException("허용되지 않은 문제 수입니다.");
        }

        if (!educationService.memberTodayEducationIsEmpty(memberId)) {
            return;
        }

        List<EducationDto> educations;
        if (categoryId == null) {
            educations =
                    educationService.NotAssignedEducations(memberId, problemCount);
        } else {
            educations =
                    educationService.NotAssignedEducations(
                            memberId,
                            problemCount,
                            categoryId);
        }

        educationService.assignEducation(memberId, educations);
    }

    @Override
    public TodayProgressDto getTodayProgress(Long memberId) {
        return homeDashboardMapper.selectTodayProgress(memberId);
    }

    @Override
    public List<GrassCellDto> getGrassCells(Long memberId) {
        return homeDashboardMapper.selectGrassCells(memberId);
    }

    @Override
    public LearningStatsDto getLearningStats(Long memberId) {
        LearningStatsDto learningStats =
                homeDashboardMapper.selectLearningStats(memberId);

        learningStats.setStreak(educationService.countStreakDay(memberId));
        return learningStats;
    }
}
