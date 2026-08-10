package com.semi.easycoding.home.service;

import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.service.EducationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.semi.easycoding.education.dto.MemberQuizHistoryDto;
import com.semi.easycoding.education.dto.TodayProgressDto;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import java.util.List;
import java.util.Set;

@Service
public class HomeDashboardServiceImpl implements HomeDashboardService {

    private static final Set<Integer> ALLOWED_PROBLEM_COUNTS =
            Set.of(3, 5, 10, 20);

    private final EducationService educationService;
    //문제 조회·배정 기능을 사용하기 위해 보관하는 필드

    public HomeDashboardServiceImpl(EducationService educationService) {
        this.educationService = educationService;
    }

    @Transactional
    @Override
    public void prepareDailyQuiz(
            Long memberId,
            int problemCount,
            Long categoryId
    ) {
        if (!ALLOWED_PROBLEM_COUNTS.contains(problemCount)) {
            throw new IllegalArgumentException(
                    "허용되지 않은 문제 수입니다."
            );
        }
        //사용자가 선택한 문제 수가 3, 5, 10, 20 중 하나인지 확인
        //허용되지 않은 숫자라면 문제 배정을 중단한다.

        if (!educationService.memberTodayEducationIsEmpty(memberId)) {
            return;
        }
        //이미 문제가 배정되었는지 확인한다.

        List<EducationDto> educations;

        if (categoryId == null) {
            educations = educationService.NotAssignedEducations(memberId, problemCount);
            //전체 선택을 한 경우
        } else {
            educations = educationService.NotAssignedEducations(memberId, problemCount, categoryId);
        }

        educationService.assignEducation(memberId, educations);
        //가져온 문제를 오늘 문제로 DB에 저장한다.
    }

    //오늘 배정된 문제를 조회한 뒤, 전체 문제 수와 답변 완료 수를 계산하여 반환
    @Override
    public TodayProgressDto getTodayProgress(Long memberId) {
        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime endOfToday = LocalDate.now().atTime(LocalTime.MAX);

        List<MemberQuizHistoryDto> histories =
                educationService.getMemberQuizHistoryAtDate(
                        memberId,
                        startOfToday,
                        endOfToday
                );

        int done = (int) histories.stream()
                .filter(MemberQuizHistoryDto::isAnswered)
                .count();

        return new TodayProgressDto(done, histories.size());
    }


}