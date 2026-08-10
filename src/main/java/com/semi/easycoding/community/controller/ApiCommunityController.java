package com.semi.easycoding.community.controller;

import com.semi.easycoding.comment.dto.CommentDto;
import com.semi.easycoding.common.util.SessionConst;
import com.semi.easycoding.community.service.CommunityService;
import com.semi.easycoding.common.dto.ApiResponse;
import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class ApiCommunityController {

    @Autowired
    private CommunityService communityService;

    // 로그인한 회원의 임시저장하나 게시글을 조회하는 메소드
    @GetMapping("/select/temporaryPost")
    public ResponseEntity<ApiResponse<List<PostDto>>> selectTemporaryPostList(
            HttpSession session
    ) {
        MemberDto loginMember = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);
        List<PostDto> temporaryPostList = communityService.selectTemporaryPostList(loginMember.getMemberId());

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(temporaryPostList));
    }

    // 임시저장한 게시글을 삭제하는 메소드
    @PostMapping("/delete/temporaryPost/{postId}")
    public ResponseEntity<ApiResponse<List<PostDto>>> deleteTemporaryPost(
            @PathVariable Long postId,
            HttpSession session
    ) {
        MemberDto loginMember = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);
        communityService.deletePost(postId, loginMember.getMemberId());
        List<PostDto> temporaryPostList = communityService.selectTemporaryPostList(loginMember.getMemberId());

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(temporaryPostList));
    }

}
