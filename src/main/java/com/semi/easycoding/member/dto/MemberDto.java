package com.semi.easycoding.member.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Setter
public class MemberDto {
    private Long memberId;
    private String email;
    private String password;
    private String nickname;
    private Short profileId;
    private String createdAt;
}
