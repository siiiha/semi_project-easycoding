package com.semi.easycoding.education.service;

import com.semi.easycoding.education.dto.EducationCategoryDto;
import com.semi.easycoding.education.dto.EducationDto;

import java.time.LocalDateTime;
import java.util.List;

public interface EducationService {

    boolean storeEducation(EducationDto myDto);
    // 전달받은 EducationDto 객체에 담긴 정보를 DB에 저장한다

    List<EducationCategoryDto> getAllEduCategory();
    // DB에서 모든 문제 카테고리 정보를 조회한다

    List<EducationDto> todayEducations(Long memberId);
    // 특정 사용자가 오늘 할당받은 학습 조회하여 반환
    // 비어있으면 새로운 학습을 할당하고, 오늘 할당받은 학습을 조회회여 반환

    boolean memberTodayEducationIsEmpty(Long memberID);
    // 특정 사용자가 오늘 할당받은 학습이 있는지 여부를 확인한다

    List<EducationDto> NotAssignedEducations(Long memberId, int qty);
    // DB에 저장된 문제풀에서 사용자에게 할당되지 않은 문제를 무작위로 n개 선택해 반환한다

    List<EducationDto> assignEducation(Long memberID, List<EducationDto> educationList);
    // 사용자에게 해당문제들을 할당한다

    List<EducationDto> userEducationAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate);
    // DB에서 특정 기간동안 사용자에게 할당된 문제들을 조회한다



}
