package com.semi.easycoding.education.mapper;

import com.semi.easycoding.education.dto.EducationCategoryDto;
import com.semi.easycoding.education.dto.EducationBlankTypeDto;
import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.EducationOptionTypeDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
    List<EducationDto> selectUserEducationAtDate(@Param("memberId") Long memberId,
                                                 @Param("startDate") LocalDateTime startDate,
                                                 @Param("endDate") LocalDateTime endDate);
    // 특정 기간 동안 사용자에게 할당된 문제 조회
    List<EducationDto> selectEducationNotAssigned(Long memberId);
    // 사용자에게 할당되지 않은 문제 조회
    List<EducationDto> selectEducationNotAssignedByCategory(@Param("memberId") Long memberId,
                                                            @Param("categoryId") Long categoryId);

    int insertMemberQuizHistory(@Param("memberId") Long memberId,
                                @Param("educationIdList") List<Long> educationIdList);
    // 사용자에게 문제를 할당, 멤버_퀴즈_히스토리 테이블에 삽입시행

}
