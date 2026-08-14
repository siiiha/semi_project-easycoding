package com.semi.easycoding.education.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EducationOptionSubmitDto {
    private Long historyId;
    private Long educationID;
    private boolean correct;
    private Short choseOption;
}
