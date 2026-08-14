package com.semi.easycoding.education.service;

import com.semi.easycoding.education.dto.*;
import com.semi.easycoding.education.mapper.EducationMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EducationServiceImp implements EducationService {

    private final EducationMapper educationMapper;

    /* 테스트를 위해서 임시로 쓴거
    private final Map<Short, String> categoryMap = Map.ofEntries(
            Map.entry((short)37, "Java기본"),
            Map.entry((short)38, "객체지향"),
            Map.entry((short)39, "클래스"),
            Map.entry((short)40, "예외처리"),
            Map.entry((short)41, "컬렉션"),
            Map.entry((short)42, "제네릭"),
            Map.entry((short)43, "JVM"),
            Map.entry((short)44, "동시성"),
            Map.entry((short)45, "함수형Java"),
            Map.entry((short)46, "프론트엔드"),
            Map.entry((short)47, "백엔드"),
            Map.entry((short)48, "데이터베이스"),
            Map.entry((short)49, "네트워크"),
            Map.entry((short)50, "운영체제"),
            Map.entry((short)51, "자료구조"),
            Map.entry((short)52, "보안")
    );*/

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
    public List<EducationDto> notAssignedEducations(Long memberId, int qty) {
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
    public List<EducationDto> notAssignedEducations(Long memberId, int qty, Short categoryId) {

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
            List<EducationDto> newEducationList = notAssignedEducations(memberId, 5); // 예시로 5개 할당
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

        List<EducationDto> todayEducation = userEducationAtDate(memberId, startOfToday, endOfToday);

        return todayEducation.stream()
                .map(this::educationDtoToType)
                .toList();
    }
    // 컨트롤러의 "/daily/quiz" 요청을 받는 서비스 오케스트레이션 메서드
    // 특정 사용자가 오늘 할당받은 학습문제들을 조회하고, 답변까지 매핑하여 반환

    public List<EducationDto> getTodayEducationsNotSubmitted(Long memberId){
        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime endOfToday = LocalDate.now().atTime(LocalTime.MAX);

        List<EducationDto> todayEducationNotSubmitted = educationMapper.selectUserEducationAtDateNotsubmitted(memberId, startOfToday, endOfToday);

        return todayEducationNotSubmitted.stream()
                .map(this::educationDtoToType)
                .toList();
    }
    // 컨트롤러의 "/daily/quiz" 요청을 받는 서비스 오케스트레이션 메서드
    // 특정 사용자가 오늘 할당받은 학습문제 중 풀지 않은 상태의 문제들을 반환


    public EducationDto educationDtoToType(EducationDto dto){
        switch(dto.getEducationType()){
            case 1:
                List<OptionDto> myOptions = getAnswerByEducationId(dto.getEducationId(), dto.getEducationType());

                return EducationOptionTypeDto.builder()
                        .educationId(dto.getEducationId())
                        .educationType(dto.getEducationType())
                        .educationCategoryID(dto.getEducationCategoryID())
                        .educationCategoryName(dto.getEducationCategoryName())
                        .educationTitle(dto.getEducationTitle())
                        .educationContent(dto.getEducationContent())
                        .educationExplanation(dto.getEducationExplanation())
                        .createdAt(dto.getCreatedAt())
                        .createdAtStr(dto.getCreatedAtStr())
                        .options(myOptions)
                        .build();
            case 2:
                // todo: 빈칸채우기에 대한 처리
                break;
            // 문제타입이 추가된다면 필요한 만큼 case 추가하기
        }
        return null;
    }
    // 전달받은 EducationDto의 문제 타입에 따라 알맞은 자식 객체로 변환

    public List<OptionDto> getAnswerByEducationId(Long educationId, Short educationType){
        switch(educationType){
            case 1:
                return educationMapper.selectOptionsByEducationId(educationId);
            case 2:
                // todo: 빈칸채우기에 대한 처리
                break;
            // 문제타입이 추가된다면 필요한 만큼 case 추가하기
        }
        return null;
    }
    // 문제ID와 타입번호를 입력받아 타입에 맞는 테이블에서 문제ID로 정답을 조회

    @Transactional
    @Override
    public boolean submitDailyAnswerByOption(EducationOptionSubmitDto submitDto, Long memberId) {
        if (submitDto == null || memberId == null || submitDto.getEducationID() == null || submitDto.getChoseOption() == null) {
            return false;
        }

        Long historyId = educationMapper.selectHistoryByMemberIdAndEducationId(memberId, submitDto.getEducationID());
        if (historyId == null) {
            return false;
        }

        int updated = educationMapper.updateMemberQuizHistory(historyId, true, submitDto.isCorrect());
        if (updated != 1) {
            return false;
        }

        int inserted = educationMapper.insertAnsweredOption(historyId, submitDto.getChoseOption());
        return inserted == 1;
    }
    // 컨트롤러의 "/daily/answer" 요청을 받는 서비스 오케스트레이션 메서드
    // 사용자가 제출한 답안을 저장하고, 히스토리 상태를 갱신

    @Override
    public EducationSummaryDto makeEducationSummary(Long memberId,
                                                    LocalDateTime startDate,
                                                    LocalDateTime endDate){

        EducationSummaryDto summary = new EducationSummaryDto();
        List<MemberQuizHistoryDto> historyList = getMemberQuizHistoryAtDate(memberId, startDate, endDate);

        summary.setCompletedCount((int) historyList.stream()
                                        .filter(MemberQuizHistoryDto::isAnswered)
                                        .count());
        summary.setCorrectCount((int) historyList.stream()
                                        .filter(MemberQuizHistoryDto::isCorrect)
                                        .count());
        summary.setAccuracyRate(summary.getCompletedCount() > 0 ?
                (double) summary.getCorrectCount() / summary.getCompletedCount() * 100 : 0.0);

        return summary;
    }
    // 일정 기간동안의 학습결과 요약 데이터를 생성하여 반환

    @Override
    public int countStreakDay(Long memberId){
        // 통과기준, 지금은 5
        final int PASS_COUNT = 5;

        // 전체 학습 이력을 넉넉한 기간으로 조회
        LocalDateTime startDate = LocalDateTime.of(2000, 1, 1, 0, 0, 0);
        LocalDateTime endDate = LocalDateTime.of(2200, 12, 31, 23, 59, 59);
        List<MemberQuizHistoryDto> historyList = getMemberQuizHistoryAtDate(memberId, startDate, endDate);

        if (historyList == null || historyList.isEmpty()) {
            return 0;
        }

        Map<LocalDate, Integer> answeredCountByDate = new HashMap<>();
        for (MemberQuizHistoryDto history : historyList) {
            if (!history.isAnswered()) {
                continue;
            }
            // 날짜별 "제출 완료 문제 수(answered=true)"만 집계
            LocalDate educationDate = history.getEducationDate().toLocalDate();
            answeredCountByDate.merge(educationDate, 1, Integer::sum);
        }

        LocalDate today = LocalDate.now();
        // 오늘은 통과(5문제 이상)한 경우에만 +1, 미학습/미완수면 0으로 시작
        int count = answeredCountByDate.getOrDefault(today, 0) >= PASS_COUNT ? 1 : 0;
        LocalDate cursor = today.minusDays(1);

        // 어제부터 과거방향으로 연속해서 통과한 날짜만 누적
        while (answeredCountByDate.getOrDefault(cursor, 0) >= PASS_COUNT) {
            count += 1;
            cursor = cursor.minusDays(1);
        }

        return count;
    }
    // 특정사용자의 연속 학습일수를 계산한다

    @Override
    public List<EducationDto> getNotAssignedEducationsByCategoryWithAnswers(Long memberId, int qty, Short categoryId) {

        List<EducationDto> educationList = notAssignedEducations(memberId, qty, categoryId);
        assignEducation(memberId, educationList);

        return educationList.stream()
                .map(this::educationDtoToType)
                .toList();
    }
    // 컨트롤러의 "/category/quiz" 요청을 받는 서비스 오케스트레이션 메서드
    // 카테코리 id를 바탕으로 사용자에게 할당되지 않은 문제를 조회하여 할당
    // 문제 타입에 따라 답변까지 묶어서 반환

    @Override
    public boolean isTodayAllClear(Long memberId){
        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime endOfToday = LocalDate.now().atTime(LocalTime.MAX);

        List<MemberQuizHistoryDto> todayHistories = getMemberQuizHistoryAtDate(memberId, startOfToday, endOfToday);

        // 리스트를 순회하며, answered가 하나라도 비어있으면 false 반환
        for (MemberQuizHistoryDto history : todayHistories) {
            if (!history.isAnswered()) {
                return false;
            }
        }
        return true;
    }
    // 오늘 할당 받은 문제를 전부 풀었는지 체크
    public List<EducationOptionTypeSubmitDto> getSubmittedEducationDtoAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate){
        List<EducationOptionTypeSubmitDto> submittedList = educationMapper.selectMemberQuizHistoryJoinAnsweredOptionJoinQuizAtDate(memberId, startDate, endDate);

        // submittedList를 순회하면서 getAnswerByEducationId메서드를 이용해 OptionDto를 조회하고
        // options에 대입
        for (EducationOptionTypeSubmitDto submitted : submittedList) {
            List<OptionDto> options = getAnswerByEducationId(submitted.getEducationId(), submitted.getEducationType());
            submitted.setOptions(options);
        }

        return submittedList;
    }
    // 컨트롤러의 "/review" 요청을 받는 서비스 오케스트레이션 메서드
    // 특정 기간동안 답변제출이 완료된 문제들을 조회하고
    // 문제 타입에 따라서 답변과 히스토리 상태까지 묶어서 반환

}
