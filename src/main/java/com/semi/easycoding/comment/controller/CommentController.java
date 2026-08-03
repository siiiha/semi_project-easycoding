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
        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");

        try {
            List<CommentDto> commentList = commentService.insertComment(postId, request.getContent(), loginUser.getMemberId());
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(commentList));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.fail(e.getMessage()));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ApiResponse.fail(e.getMessage()));
        }
    }

    @PostMapping("/update/{postId}/{commentId}")
    public ResponseEntity<ApiResponse<List<CommentDto>>> updateComment(
            @PathVariable Long postId,
            @PathVariable Long commentId,
            @RequestBody CommentRequest request,
            HttpSession session
    ) {
        System.out.println("댓글 수정 요청 들어옴");
        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");

        try {
            List<CommentDto> commentList = commentService.updateComment(postId, commentId, request.getContent(), loginUser.getMemberId());
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(commentList));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.fail(e.getMessage()));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ApiResponse.fail(e.getMessage()));
        }
    }

}
