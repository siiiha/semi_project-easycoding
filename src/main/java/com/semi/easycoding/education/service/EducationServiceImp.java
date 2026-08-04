package com.semi.easycoding.education.service;

import com.semi.easycoding.education.dto.*;
import com.semi.easycoding.education.mapper.EducationMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Collections;
import java.util.List;

@Service
public class EducationServiceImp implements EducationService {

    private final EducationMapper educationMapper;

    public EducationServiceImp(EducationMapper educationMapper){
        this.educationMapper = educationMapper;
    }

    @Transactional
    @Override
    public boolean storeEducation(EducationDto myDto) {

        educationMapper.insertQuiz(myDto);

        if(myDto instanceof EducationOptionTypeDto optionDto){
            educationMapper.insertOptions(optionDto);
        }
        else if(myDto instanceof EducationBlankTypeDto blankDto){
            educationMapper.insertBlank(blankDto);
        } else{
            return false;
        }
        return true;
    }
    // 전달받은 EducationDto 객체에 담긴 정보를 DB에 저장한다

    @Override
    public List<EducationDto> userEducationAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate) {
        return educationMapper.selectUserEducationAtDate(memberId, startDate, endDate);
    }
    // DB에서 특정 기간동안 사용자에게 할당된 문제들을 조회한다

    @Override
    public List<MemberQuizHistoryDto> getMemberQuizHistoryAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate) {
        return educationMapper.selectMemberQuizHistoryAtDate(memberId, startDate, endDate);
    }

    @Override
    public boolean memberTodayEducationIsEmpty(Long memberId) {
        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime endOfToday = LocalDate.now().atTime(LocalTime.MAX);

        List<EducationDto> todayEducation = userEducationAtDate(memberId, startOfToday, endOfToday);
        return todayEducation.isEmpty();
    }
    // 특정 사용자가 오늘 할당받은 학습이 있는지 여부를 확인한다
    // 이거 로직 짜보니까 필요가 없는데?

    @Override
    public List<EducationDto> NotAssignedEducations(Long memberId, int qty) {
        // DB에 저장된 문제풀에서 사용자에게 할당되지 않은 문제들을 전부 받아옴
        List<EducationDto> educationList = educationMapper.selectEducationNotAssigned(memberId);

        // 리스트를 무작위로 섞고 앞의 n개 꺼내옴
        // 리스트가 qty보다 작으면 오류 날 수 있어서 최솟값 활용
        Collections.shuffle(educationList);
        educationList = educationList.subList(0, Math.min(qty, educationList.size()));
        return educationList;
    }
    // DB에 저장된 문제풀에서 사용자에게 할당되지 않은 문제를 무작위로 n개 선택해 반환한다

    @Override
    public List<EducationDto> NotAssignedEducations(Long memberId, int qty, Long categoryId) {

        List<EducationDto> educationList = educationMapper.selectEducationNotAssignedByCategory(memberId, categoryId);
        // 리스트를 무작위로 섞고 앞의 n개 꺼내옴
        // 리스트가 qty보다 작으면 오류 날 수 있어서 최솟값 활용
        Collections.shuffle(educationList);
        educationList = educationList.subList(0, Math.min(qty, educationList.size()));
        return educationList;
    }
    // (카테고리별) DB에 저장된 문제풀에서 사용자에게 할당되지 않은 문제를 무작위로 n개 선택해 반환한다

    @Override
    public List<EducationDto> assignEducation(Long memberId, List<EducationDto> educationList) {
        if(educationList == null || educationList.isEmpty()) {
            return Collections.emptyList();
        }
        List<Long> educationIdList = educationList.stream()
                                                  .map(EducationDto::getEducationId)
                                                  .toList();
        educationMapper.insertMemberQuizHistory(memberId, educationIdList);
        return educationList;
    }
    // 사용자에게 해당문제들을 할당한다


    @Override
    public List<EducationCategoryDto> getAllEduCategory() {
        return educationMapper.selectAllEduCategory();
    }
    // DB에서 모든 문제 카테고리 정보를 조회한다

    @Override
    public List<MemberQuizHistoryDto> todayEducations(Long memberId) {
        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime endOfToday = LocalDate.now().atTime(LocalTime.MAX);

        List<MemberQuizHistoryDto> todayEducationHistory = getMemberQuizHistoryAtDate(memberId, startOfToday, endOfToday);

        if (todayEducationHistory.isEmpty()) {
            List<EducationDto> newEducationList = NotAssignedEducations(memberId, 5); // 예시로 5개 할당
            assignEducation(memberId, newEducationList);
            todayEducationHistory = getMemberQuizHistoryAtDate(memberId, startOfToday, endOfToday);
        }
        return todayEducationHistory;
    }
    // 컨트롤러의 "/daily" 요청을 받는 서비스 오케스트레이션 메서드
    // 특정 사용자가 오늘 할당받은 학습에대한 현황을 조회하여 반환
    // 비어있으면 새로운 학습을 할당하고, 오늘 할당받은 학습의 현황을 조회하여 반환

    public List<EducationDto> getTodayEducations(Long memberId){
        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime endOfToday = LocalDate.now().atTime(LocalTime.MAX);

        return userEducationAtDate(memberId, startOfToday, endOfToday);
    }
    // 컨트롤러의 "/daily/quiz" 요청을 받는 서비스 오케스트레이션 메서드
    // 특정 사용자가 오늘 할당받은 학습문제들을 조회하여 반환

}
