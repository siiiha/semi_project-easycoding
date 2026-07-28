package com.semi.easycoding.education.service;

import com.semi.easycoding.agent.ApiKeyValidator;
import com.semi.easycoding.agent.service.AgentServiceImp;
import com.semi.easycoding.education.dto.EducationBlankTypeDto;
import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.EducationOptionTypeDto;
import com.semi.easycoding.education.mapper.EducationMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

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
    public EducationDto requestUserEducation(Long EducationID, Long userId) {
        return null;
    }

    @Override
    public EducationDto[] lookupUserEducationAtDate(Long UserId, LocalDateTime startDate, LocalDateTime endDate) {
        return new EducationDto[0];
    }
}
