package com.semi.easycoding.community.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PopularMemberDto {
    private Long memberId;      // 회원 아이디(PK)
    private String nickname;    // 닉네임
    // 프로필 이미지
    private int postCount;          // 게시글 수
}
