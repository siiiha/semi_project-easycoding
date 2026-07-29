package com.semi.easycoding.education.mapper;

import com.semi.easycoding.education.dto.EducationBlankTypeDto;
import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.EducationOptionTypeDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EducationMapper {

    int insertQuiz(EducationDto myDto);
    int insertOptions(EducationOptionTypeDto myDto);
    int insertBlank(EducationBlankTypeDto myDto);

}
