package com.semi.easycoding.education.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class EducationDto {
    private Long EducationId;
    private Short EducationType;
    private String EducationTitle;
    private String EducationContent;
    private LocalDateTime createdAt;
    private String createdAtStr;    // 화면 표시용 문자열
}
