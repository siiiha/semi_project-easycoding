package com.semi.easycoding.comment.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentRequest {
    private String content; // 댓글 내용
    private Long parentId; // 부모 댓글 번호
}
