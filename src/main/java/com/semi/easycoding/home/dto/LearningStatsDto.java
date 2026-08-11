package com.semi.easycoding.home.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class LearningStatsDto {

    private int streak;
    private int totalSolved;
    private double correctRate;
}
