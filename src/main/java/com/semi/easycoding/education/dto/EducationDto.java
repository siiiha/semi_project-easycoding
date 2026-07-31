package com.semi.easycoding.education.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EducationDto {
    private Long educationId;
    private Short educationType;
    private Short educationCategoryID;
    private String educationCategoryName;
    private String educationTitle;
    private String educationContent;
    private String educationExplanation;
    private LocalDateTime createdAt;
    private String createdAtStr; // 화면 표시용 문자열
}
