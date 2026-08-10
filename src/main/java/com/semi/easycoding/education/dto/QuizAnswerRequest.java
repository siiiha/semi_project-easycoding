package com.semi.easycoding.education.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuizAnswerRequest {

    private Long quizId;
    private Short selectedOptionNumber;
}