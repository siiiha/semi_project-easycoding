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
    private Long optionId;
    private String optionContent;
    private boolean isCorrect;
    private Integer orderingNumber;
}
