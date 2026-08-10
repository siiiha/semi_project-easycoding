package com.semi.easycoding.community.dto;

import lombok.*;

import java.time.LocalDateTime;

@ToString
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PostDto {
    private Long postId;        // 게시글 번호
    private Long memberId;    // 작성자 번호 (PK)
    private String category;    // 카테고리
    private int categoryId;    // post테이블에 저장할 FK (카테고리 번호)
    private String title;       // 제목
    private String content;     // 내용
    private String nickname;    // 작성자 닉네임
    private int views;          // 조회수
    private LocalDateTime createAt; // 작성일
    private int temporaryStatus = 0;    // 임시저장 여부

    private String createdAtStr;     // 화면에 보여줄 작성일 (문자열)
}
