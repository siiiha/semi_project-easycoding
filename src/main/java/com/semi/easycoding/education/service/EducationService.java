package com.semi.easycoding.education.service;

import com.semi.easycoding.education.dto.*;


import java.time.LocalDateTime;
import java.util.List;

public interface EducationService {

    boolean storeEducation(EducationDto myDto);
    // 전달받은 EducationDto 객체에 담긴 정보를 DB에 저장한다

    List<EducationCategoryDto> getAllEduCategory();
    // DB에서 모든 문제 카테고리 정보를 조회한다

    List<MemberQuizHistoryDto> todayEducations(Long memberId);
    // 컨트롤러의 "/daily" 요청을 받는 서비스 오케스트레이션 메서드
    // 특정 사용자가 오늘 할당받은 학습에대한 현황을 조회하여 반환
    // 비어있으면 새로운 학습을 할당하고, 오늘 할당받은 학습의 현황을 조회하여 반환

    List<EducationDto> getTodayEducations(Long memberId);
    // 컨트롤러의 "/daily/quiz" 요청을 받는 서비스 오케스트레이션 메서드
    // 특정 사용자가 오늘 할당받은 학습문제들을 조회하여 반환

    List<EducationDto> getTodayEducationsNotSubmitted(Long memberId);
    // 컨트롤러의 "/daily/quiz" 요청을 받는 서비스 오케스트레이션 메서드
    // 특정 사용자가 오늘 할당받은 학습문제 중 풀지 않은 상태의 문제들을 반환

    boolean memberTodayEducationIsEmpty(Long memberId);
    // 특정 사용자가 오늘 할당받은 학습이 있는지 여부를 확인한다

    List<EducationDto> notAssignedEducations(Long memberId, int qty);

    // DB에 저장된 문제풀에서 사용자에게 할당되지 않은 문제를 무작위로 n개 선택해 반환한다
    List<EducationDto> notAssignedEducations(Long memberId, int qty, Short categoryId);
    // (카테고리별) DB에 저장된 문제풀에서 사용자에게 할당되지 않은 문제를 무작위로 n개 선택해 반환한다

    List<EducationDto> assignEducation(Long memberId, List<EducationDto> educationList);
    // 사용자에게 해당문제들을 할당한다

    List<EducationDto> userEducationAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate);
    // DB에서 특정 기간동안 사용자에게 할당된 문제들을 조회한다

    List<MemberQuizHistoryDto> getMemberQuizHistoryAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate);
    // DB에서 특정 기간동한 사용자에게 할당된 문제들의 상태를 조회한다

    EducationDto educationDtoToType(EducationDto dto);
    // 전달받은 EducationDto의 문제 타입에 따라 알맞은 자식 객체로 변환

    List<OptionDto> getAnswerByEducationId(Long educationId, Short educationType);
    // 문제ID와 타입번호를 입력받아 타입에 맞는 테이블에서 문제ID로 정답을 조회

    boolean submitDailyAnswerByOption(EducationOptionSubmitDto submitDto, Long memberId);
    // 컨트롤러의 "/daily/answer" 요청을 받는 서비스 오케스트레이션 메서드
    // 사용자가 제출한 답안을 저장하고, 히스토리 상태를 갱신

    EducationSummaryDto makeEducationSummary(Long memberId, LocalDateTime startDate, LocalDateTime endDate);
    // 일정 기간동안의 학습결과 요약 데이터를 생성하여 반환

    int countStreakDay(Long memberId);
    // 특정사용자의 연속 학습일수를 계산한다

    List<EducationDto> getNotAssignedEducationsByCategoryWithAnswers(Long memberId, int qty, Short categoryId);
    // 컨트롤러의 "/category/quiz" 요청을 받는 서비스 오케스트레이션 메서드
    // 카테코리 id를 바탕으로 사용자에게 할당되지 않은 문제를 조회하여 할당
    // 문제 타입에 따라 답변까지 묶어서 반환

    /*
     * 조건 1 : 카테고리 학습은 일일학습을 완료한 사용자만 가능하다
     * 사용자가 학습메뉴로 이동하는 분기는 총 3갈래
     * 분기1 : 헤더 네비바의 '학습하기'를 선택
     * 분기2 : '일일퀴즈' 선택
     * 분기3 : '카테고리학습' 선택
     *
     * 조건에 따라 분기별 수행될 로직은 다음과 같다
     * 분기1
     *  - 무조건 '일일퀴즈'로 보낸다
     * 분기2
     *  - 일일퀴즈 현황을 확인
     *  - 현황 정보를 화면에 표시한다(몇개의 문제를 풀었고, 몇개를 맞췄는지?)
     * 분기3
     *  - 일일퀴즈 현황을 확인
     *  - 완료되었다면 카테고리학습페이지로 이동
     *  - 미완료시 '일일퀴즈'로 보낸다
     *
     * 실질적으로 컨트롤러에서 요청에 응답하는데 필요한 로직
     * 1. 일일퀴즈
     *  1-1. 일일퀴즈 상태데이터 조회 ( 해당 데이터가 비어있지 않으면 1-5 분기)
     *  1-2. 무작위로 문제 5개 조회
     *  1-3. 조회된 문제를 사용자에게 할당
     *  1-4. 일일퀴즈 상태데이터 조회
     *  1-5. 조회된 데이터 모델에 담아서 페이지 반환
     * 2. 카테고리학습
     *  2-1. 일일퀴즈 상태데이터 조회 ( 해당 데이터가 비어있거나 & 하나라도 미완료상태라면 2-3 분기)
     *  2-2. 카테고리학습 페이지 반환
     *  2-3. 일일퀴즈 쪽으로 보낸다
     *
     * */

}
