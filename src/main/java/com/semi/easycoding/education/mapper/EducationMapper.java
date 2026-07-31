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
    int insertOptions(EducationOptionTypeDto myDto);
    int insertBlank(EducationBlankTypeDto myDto);
    List<EducationCategoryDto> selectAllEduCategory();
    List<EducationDto> selectUserEducationAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate);

}
