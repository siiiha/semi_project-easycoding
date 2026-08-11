package com.semi.easycoding.community.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SaveTemporaryPostDto {
    private Long postId;        // 임시저장한 게시글의 PK
    private String title;       // 게시글 제목
    private String content;     // 게시글 내용
    private String category;    // 카테고리 'all', 'qna', 'solution', 'problem'
    private int temporaryStatus;    // 임시저장 여부 => 1: 임시저장, 0: 일반저장
}
