package com.semi.easycoding.education.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EducationOptionTypeDto extends EducationDto {
    private Long[] optionId;
    private String[] optionContents;
    private boolean[] isCorrect;
    private Short[] orderingNumber;
}
