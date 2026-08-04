package com.semi.easycoding.comment.service;

import com.semi.easycoding.comment.dto.CommentDto;
import com.semi.easycoding.comment.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    /**
     * 게시글 상세 조회 시 해당 게시글의 댓글을 조회하는 메소드
     * @param postId
     * @return
     */
    @Override
    public List<CommentDto> selectCommentByPostId(Long postId) {
        return commentMapper.selectCommentList(postId);
    }

    /**
     * 댓글 작성 시 DB에 추가 후 게시글의 댓글 정보를 조회하는 메소드
     * @param postId
     * @param content
     * @param memberId
     * @return
     */
    @Override
    public List<CommentDto> insertComment(Long postId, String content, String memberId) {
        if (content == null || content.equals("")) {
            throw new IllegalArgumentException("댓글 내용을 입력해주세요.");
        }

        CommentDto comment = new CommentDto();
        comment.setPostId(postId);
        comment.setMemberId(memberId);
        comment.setContent(content);

        int result = commentMapper.insertComment(comment);   // 실행 후 생성 된 commentId가 채워짐
        if (result != 1) {
            // DB에 추가 안된 경우 로직
        }
        return commentMapper.selectCommentList(comment.getPostId());
    }
}
