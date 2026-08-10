package com.semi.easycoding.comment.dto;

import lombok.*;

import java.time.LocalDateTime;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CommentDto {
    private Long commentId;     // 댓글 번호(PK)
    private Long postId;        // 게시글 번호(FK)
    private Long parentId;      //부모 댓글 번호(FK)
    private Long memberId;    // 작성자 번호(FK)
    private String profileId;       // 이미지 번호
    private String content;     // 댓글 내용
    private LocalDateTime createdAt; // 작성날짜

    private String nickname;    // 작성자 닉네임
    private String createdAtStr; // 실제 화면에 보여질 작성날짜 문자열
}
