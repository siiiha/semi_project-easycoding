package com.semi.easycoding.education.service;

import com.semi.easycoding.education.dto.EducationDto;

import java.time.LocalDateTime;

public interface EducationService {

    boolean storeEducation(EducationDto myDto);
    // 전달받은 EducationDto 객체에 담긴 정보를 DB에 저장한다

    EducationDto requestUserEducation(Long EducationID, Long userId);
    // DB에 저장된 문제풀에서 사용자에게 할당되지 않은 문제하나를 무직위로 할당하고 그 문제를 반환한다

    EducationDto[] lookupUserEducationAtDate(Long UserId, LocalDateTime startDate, LocalDateTime endDate);
    // DB에서 특정 기간동안 사용자에게 할당된 문제들을 조회한다
}
