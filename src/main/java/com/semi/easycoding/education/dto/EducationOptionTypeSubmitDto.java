package com.semi.easycoding.education.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EducationOptionTypeSubmitDto {
    private Long educationId;
    private Short educationType;
    private Short educationCategoryID;
    private String educationCategoryName;
    private String educationTitle;
    private String educationContent;
    private String educationExplanation;
    private List<OptionDto> options;
    private Long historyId;
    private boolean answered;
    private boolean correct;
    private Short choseOption;
}
