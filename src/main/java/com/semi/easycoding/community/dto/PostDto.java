package com.semi.easycoding.community.dto;

import lombok.*;

import java.time.LocalDateTime;

@ToString
@Getter
@Setter
@AllArgsConstructor
public class PostDto {
    private Long postId;        // 게시글 번호
    private String category;    // 카테고리
    private String title;       // 제목
    private String content;     // 내용
    private String nickname;    // 작성자 닉네임
    private int views;          // 조회수
    private LocalDateTime createAt; // 작성일

    private String createdAtStr;     // 화면에 보여줄 작성일 (문자열)
}
