package com.semi.easycoding.home.service;

import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.EducationSummaryDto;
import com.semi.easycoding.education.service.EducationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.semi.easycoding.home.dto.TodayProgressDto;
import com.semi.easycoding.home.mapper.HomeDashboardMapper;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.ArrayList;
import com.semi.easycoding.home.dto.GrassCellDto;
import com.semi.easycoding.home.dto.GrassMonthDto;
import com.semi.easycoding.home.dto.LearningStatsDto;
import com.semi.easycoding.home.dto.TodayProgressDto;
import com.semi.easycoding.home.mapper.HomeDashboardMapper;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.ArrayList;
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
            Short categoryId) {
        if (!ALLOWED_PROBLEM_COUNTS.contains(problemCount)) {
            throw new IllegalArgumentException("허용되지 않은 문제 수입니다.");
        }
        //사용자가 선택한 문제 수가 3, 5, 10, 20 중 하나인지 확인
        //허용되지 않은 숫자라면 문제 배정을 중단한다.

        if (!educationService.memberTodayEducationIsEmpty(memberId)) {
            return;
        }
        //이미 문제가 배정되었는지 확인한다.

        List<EducationDto> educations;
        if (categoryId == null) {
            educations = educationService.notAssignedEducations(memberId, problemCount);
        } else {
            educations =
                    educationService.notAssignedEducations(
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
    public List<GrassMonthDto> getGrassMonths(Long memberId) {
        List<GrassCellDto> grassCells = homeDashboardMapper.selectGrassCells(memberId);
        List<GrassMonthDto> grassMonths = new ArrayList<>();

        YearMonth currentMonth = null;
        List<GrassCellDto> monthCells = null;

        for (GrassCellDto grassCell : grassCells) {
            YearMonth cellMonth = YearMonth.from(grassCell.getDate());

            if (!cellMonth.equals(currentMonth)) {
                monthCells = new ArrayList<>();

                DayOfWeek firstDayOfWeek = cellMonth.atDay(1).getDayOfWeek();
                int leadingEmptyCellCount = firstDayOfWeek.getValue() % 7;

                grassMonths.add(
                        new GrassMonthDto(
                                cellMonth.getYear(),
                                cellMonth.getMonthValue(),
                                leadingEmptyCellCount,
                                monthCells));
                currentMonth = cellMonth;
            }

            monthCells.add(grassCell);
        }

        return grassMonths;
    }

    @Override
    public LearningStatsDto getLearningStats(Long memberId) {
        EducationSummaryDto summary =
                educationService.makeEducationSummary(
                        memberId,
                        LocalDateTime.of(2000, 1, 1, 0, 0),
                        LocalDateTime.now());

        LearningStatsDto learningStats = new LearningStatsDto();
        learningStats.setTotalSolved(summary.getCompletedCount());
        learningStats.setCorrectRate(summary.getAccuracyRate());
        learningStats.setStreak(educationService.countStreakDay(memberId));

        return learningStats;
    }
}
