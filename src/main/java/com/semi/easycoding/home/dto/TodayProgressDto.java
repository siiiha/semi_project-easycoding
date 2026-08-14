package com.semi.easycoding.home.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TodayProgressDto {

    private int done;
    private int total;

    public int getPercent() {
        return total == 0 ? 0 : done * 100 / total;
    }
}
