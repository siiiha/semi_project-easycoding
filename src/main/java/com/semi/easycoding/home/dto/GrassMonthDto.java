package com.semi.easycoding.home.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class GrassMonthDto {

    private int year;
    private int month;
    private int leadingEmptyCellCount;
    private List<GrassCellDto> cells;
}
