package com.semi.easycoding.education.mapper;

import com.semi.easycoding.education.dto.EducationCategoryDto;
import com.semi.easycoding.education.dto.EducationBlankTypeDto;
import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.EducationOptionTypeDto;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface EducationMapper {

    int insertQuiz(EducationDto myDto);
    // 문제 삽입
    int insertOptions(EducationOptionTypeDto myDto);
    // 객관식 답변 삽입
    int insertBlank(EducationBlankTypeDto myDto);
    // 주관식 답변 삽입
    List<EducationCategoryDto> selectAllEduCategory();
    // 모든 문제 카테고리 조회
    List<EducationDto> selectUserEducationAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate);
    // 특정 기간 동안 사용자에게 할당된 문제 조회
    List<EducationDto> selectEducationNotAssigned(Long memberId);
    // 사용자에게 할당되지 않은 문제 조회

}
