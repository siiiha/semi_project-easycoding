package com.semi.easycoding.comment.controller;

import com.semi.easycoding.comment.dto.CommentDto;
import com.semi.easycoding.comment.dto.CommentRequest;
import com.semi.easycoding.comment.service.CommentService;
import com.semi.easycoding.common.dto.ApiResponse;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.xml.stream.events.Comment;
import java.util.List;

@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    CommentService commentService;

    @PostMapping("/select/{postId}")
    public ResponseEntity<ApiResponse<List<CommentDto>>> selectComment(@PathVariable Long postId) {
        try {
            List<CommentDto> commentList = commentService.selectCommentByPostId(postId);
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(commentList));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ApiResponse.fail(e.getMessage()));
        }
    }

    @PostMapping("/insert/{postId}")
    public ResponseEntity<ApiResponse<List<CommentDto>>> insertComment(
            @PathVariable Long postId,
            @RequestBody CommentRequest request,
            HttpSession session
    ) {
        // session영역에 저장되어있는 요청을 보낸 사용자의 memberId를 사용하기 위함
        MemberDto loginUser = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);

        try {
            List<CommentDto> commentList = commentService.insertComment(postId, request.getContent(), loginUser.getMemberId());
            if (commentList == null) {
                // 댓글 등록 실패 시 로직
                return ResponseEntity
                        .status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(
                            ApiResponse.fail("댓글 등록에 실패했습니다.")
                        );
            }
            // 댓글 등록 성공 시 로직
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(commentList));
        } catch (IllegalArgumentException e) {
            // Service에서 내용이 비어있는 경우 발생시킨 예외를 잡아서 응답을 주기위해서 사용
            return ResponseEntity.badRequest().body(ApiResponse.fail(e.getMessage()));
        }
    }

    @PostMapping("/update/{postId}/{commentId}")
    public ResponseEntity<ApiResponse<List<CommentDto>>> updateComment(
            @PathVariable Long postId,
            @PathVariable Long commentId,
            @RequestBody CommentRequest request,
            HttpSession session
    ) {
        // session영역에 저장되어있는 요청을 보낸 사용자의 memberId를 사용하기 위함
        MemberDto loginUser = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);

        try {
            List<CommentDto> commentList = commentService.updateComment(postId, commentId, request.getContent(), loginUser.getMemberId());
            if (commentList == null) {
                // 댓글 수정 실패 시 로직
                return ResponseEntity
                        .status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(
                                ApiResponse.fail("댓글 수정에 실패했습니다.")
                        );
            }
            // 댓글 수정 성공 시 로직
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(commentList));
        } catch (IllegalArgumentException e) {
            // Service에서 내용이 비어있는 경우 발생시킨 예외를 잡아서 응답을 주기위해서 사용
            return ResponseEntity.badRequest().body(ApiResponse.fail(e.getMessage()));
        }
    }

    @PostMapping("/delete/{postId}/{commentId}")
    public ResponseEntity<ApiResponse<List<CommentDto>>> deleteComment(
            @PathVariable Long postId,
            @PathVariable Long commentId,
            HttpSession session
    ) {
        // session영역에 저장되어있는 요청을 보낸 사용자의 memberId를 사용하기 위함
        MemberDto loginUser = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);

        try {
            List<CommentDto> commentList = commentService.deleteComment(postId, commentId, loginUser.getMemberId());
            if (commentList == null) {
                // 댓글 삭제 실패 시 로직
                return ResponseEntity
                        .status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(
                                ApiResponse.fail("댓글 삭제에 실패했습니다.")
                        );
            }
            // 댓글 삭제 성공 시 로직
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(commentList));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.fail(e.getMessage()));
        }
    }

}
