package com.semi.easycoding.education.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EducationBlankTypeDto extends EducationDto {
    private Long[] blankId;
    private String[] blankContent;
    private Short[] orderingNumber;
}
