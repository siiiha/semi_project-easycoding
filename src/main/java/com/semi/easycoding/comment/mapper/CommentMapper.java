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

    int updateComment(CommentDto comment);

    // 특정 댓글의 deleted_at을 삭제하는 시점으로 수정하는 메소드 (사실상 삭제)
    int deleteComment(CommentDto commentDto);

    //parentId로 부모 댓글 조회하는 메소드
    CommentDto selectCommentById(Long commentId);
}
