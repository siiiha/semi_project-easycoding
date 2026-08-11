package com.semi.easycoding.home.dto;

import java.time.LocalDate;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GrassCellDto {

    private LocalDate date;
    private int level;
}
