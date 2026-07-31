package com.semi.easycoding.education.service;

import com.semi.easycoding.education.dto.EducationCategoryDto;
import com.semi.easycoding.education.dto.EducationBlankTypeDto;
import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.EducationOptionTypeDto;
import com.semi.easycoding.education.mapper.EducationMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
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

    @Override
    public List<EducationDto> userEducationAtDate(Long memberId, LocalDateTime startDate, LocalDateTime endDate) {
        return educationMapper.selectUserEducationAtDate(memberId, startDate, endDate);
    }

    @Override
    public boolean memberTodayEducationIsEmpty(Long memberID) {

    }





// 이 밑으로 구현해야함
    @Override
    public EducationDto requestUserEducation(Long educationId, Long memberId) {
        return null;
    }



    @Override
    public List<EducationCategoryDto> getAllEduCategory() {
        return educationMapper.selectAllEduCategory();
    }

}
