package com.semi.easycoding.comment.service;

import com.semi.easycoding.comment.dto.CommentDto;

import java.util.List;

public interface CommentService {
    List<CommentDto> selectCommentByPostId(Long postId);

    List<CommentDto> insertComment(Long postId, String content, String memberId);
}
