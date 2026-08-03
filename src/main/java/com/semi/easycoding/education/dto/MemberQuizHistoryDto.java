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
public class MemberQuizHistoryDto {
    Long historyId;
    Long educationId;
    boolean answered;
    boolean correct;
    LocalDateTime educationDate;
    String educationDateStr; // 화면 표시용 문자열


}
