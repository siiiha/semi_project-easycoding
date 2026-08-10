package com.semi.easycoding.comment.service;

import com.semi.easycoding.comment.dto.CommentDto;
import com.semi.easycoding.comment.mapper.CommentMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
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
    public List<CommentDto> insertComment(Long postId, Long parentId, String content, Long memberId) {
        if (content == null || content.equals("")) {
            throw new IllegalArgumentException("댓글 내용을 입력해주세요.");
        } else if (content.length() > 300) {
            throw new IllegalArgumentException("댓글을 300자 이하로 작성해주세요.");
        }

        if (parentId != null) {
            CommentDto parentComment = commentMapper.selectCommentById(parentId);
            if (parentComment == null) {
                throw new IllegalArgumentException("부모 댓글을 찾을 수 없습니다.");
            }

            if (!parentComment.getPostId().equals(postId)) {
                throw new IllegalArgumentException("같은 게시글의 댓글에만 답글을 작성할 수 있습니다.");
            }

            if (parentComment.getParentId() != null) {
                throw new IllegalArgumentException("대댓글에는 답글을 작성할 수 없습니다.");
            }

        }

        CommentDto comment = new CommentDto();
        comment.setPostId(postId);
        comment.setParentId(parentId);
        comment.setMemberId(memberId);
        comment.setContent(content);

        int result = commentMapper.insertComment(comment);

        if (result != 1) {
            // DB에 추가 안된 경우 로직
            throw new IllegalStateException("댓글 등록에 실패했습니다.");
        }
        return commentMapper.selectCommentList(comment.getPostId());
    }

    /**
     * 수정하려는 댓글의 회원이 로그인한 회원이 맞는지 확인 후 DB에 댓글 수정하는 메소드
     * @param commentId
     * @param memberId
     * @param content
     * @param memberId
     * @return
     */
    @Override
    public List<CommentDto> updateComment(Long postId, Long commentId, String content, Long memberId) {

        CommentDto comment = new CommentDto();
        comment.setPostId(postId);
        comment.setMemberId(memberId);
        comment.setCommentId(commentId);
        comment.setContent(content);
        int result = commentMapper.updateComment(comment);

        if (result < 1) {
            // 업데이트 실패 했을 경우
            throw new IllegalStateException("수정 권한이 없거나 댓글이 존재하지 않습니다.");
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
    public List<CommentDto> deleteComment(Long postId, Long commentId, Long memberId) {
        int result = commentMapper.deleteComment(commentId);
        if (result < 1) {
            // 삭제 실패한 경우
            throw new IllegalStateException("삭제 권한이 없거나 댓글이 존재하지 않습니다.");
        }

        return commentMapper.selectCommentList(postId);
    }
}
