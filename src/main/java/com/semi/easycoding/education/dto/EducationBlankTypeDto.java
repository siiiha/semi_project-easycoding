package com.semi.easycoding.education.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EducationBlankTypeDto extends EducationDto {
    private Long[] blankId;
    private String[] blankContent;
    private Short[] orderingNumber;
    //todo 객관식 쪽처럼 BlankDto를 추가하고 List로 묶기
    //system-prompt-blank.st 쪽도 이름 변경해야함
}
