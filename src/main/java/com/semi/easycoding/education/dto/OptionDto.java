package com.semi.easycoding.education.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OptionDto {
    private Long optionId;
    private String optionContents;
    private boolean correct;
    private Short orderingNumber;
}
