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

    /**
     * 수정하려는 댓글의 회원이 로그인한 회원이 맞는지 확인 후 DB에 댓글 수정하는 메소드
     * @param commentId
     * @param content
     * @param memberId
     * @return
     */
    @Override
    public List<CommentDto> updateComment(Long postId, Long commentId, String content, String memberId) {
        // String인 memberId를 Long형태로 변환
        Long longMemberId = Long.valueOf(memberId);

        // 수정하려는 댓글의 작성자를 조회하는 메소드
        Long writerId = commentMapper.selectCommentWriter(commentId);
        if (!writerId.equals(longMemberId)) {
            return null;    // 수정하려는 댓글의 작성자와 로그인한 회원이 다를 경우
        }
        CommentDto comment = new CommentDto();
        comment.setPostId(postId);
        comment.setCommentId(commentId);
        comment.setContent(content);
        int result = commentMapper.updateComment(comment);

        if (result < 1) {
            return null;    // 업데이트 실패 했을 경우
        }

        return commentMapper.selectCommentList(comment.getPostId());
    }

    /**
     * 삭제하려는 댓글의 회원이 로그인한 회원이 맞는지 확인 후 DB에 댓글을 삭제하는 메소드
     * @param commentId
     * @param memberId
     * @return
     */
    @Override
    public List<CommentDto> deleteComment(Long postId, Long commentId, String memberId) {
        // String인 memberId를 Long형태로 변환
        Long longMemberId = Long.valueOf(memberId);

        // 삭제하려는 댓글의 작성자를 조회하는 메소드
        Long writerId = commentMapper.selectCommentWriter(commentId);
        if (!writerId.equals(longMemberId)) {
            return null;    // 삭제하려는 댓글의 작성자와 로그인한 회원이 다를 경우
        }
        int result = commentMapper.deleteComment(commentId);
        if (result < 1) {
            return null;    // 삭제 실패한 경우
        }

        return commentMapper.selectCommentList(postId);
    }
}
