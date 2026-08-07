package com.semi.easycoding.comment.service;

import com.semi.easycoding.comment.dto.CommentDto;

import java.util.List;

public interface CommentService {
    List<CommentDto> selectCommentByPostId(Long postId);

    List<CommentDto> insertComment(Long postId, Long parentId, String content, String memberId);

    List<CommentDto> updateComment(Long postId, Long commentId, String content, String memberId);

    List<CommentDto> deleteComment(Long postId, Long commentId, String memberId);

}
