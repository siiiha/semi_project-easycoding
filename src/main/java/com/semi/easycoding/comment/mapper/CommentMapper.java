package com.semi.easycoding.comment.mapper;

import com.semi.easycoding.comment.dto.CommentDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentMapper {
    // 댓글 등록하는 메소드
    int insertComment(CommentDto comment);

    // 게시글 번호로 댓글 조회하는 메소드
    List<CommentDto> selectCommentList(Long postId);

    // 특정 댓글을 작성한 회원의 Id를 조회하는 메소드
    Long selectCommentWriter(Long commentId);

    int updateComment(CommentDto comment);
}
