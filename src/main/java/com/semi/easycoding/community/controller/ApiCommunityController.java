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

    // 로그인한 회원의 임시저장한 게시글을 조회하는 메소드
    @GetMapping("/select/temporaryPost")
    public ResponseEntity<ApiResponse<List<PostDto>>> selectTemporaryPostList(
            HttpSession session
    ) {
        MemberDto loginMember = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);
        List<PostDto> temporaryPostList = communityService.selectTemporaryPostList(loginMember.getMemberId());

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(temporaryPostList));
    }

    // 임시저장 하고 다시 임시저장한 게시글을 조회하는 메소드
    @PostMapping("/insert/temporaryPost")
    public ResponseEntity<ApiResponse<List<PostDto>>> insertTemporaryPost(
            @ModelAttribute PostDto postDto,
            HttpSession session
    ) {
        System.out.println(postDto);
        // 게시글 제목의 빈값 여부와 글자 수 제한을 통해 예외 발생
        if (postDto.getTitle() == null || postDto.getTitle().isBlank()) {
            throw new IllegalArgumentException("제목을 입력해주세요.");
        } else if (postDto.getTitle().length() > 85) {
            throw new IllegalArgumentException("제목은 85자 이내로 작성해주세요.");
        }

        // 게시글 내용의 빈값 여부와 글자 수 제한을 통해 예외 발생
        if (postDto.getContent() == null || postDto.getContent().isBlank()) {
            throw new IllegalArgumentException("내용을 입력해주세요.");
        } else if (postDto.getContent().length() > 30000) {
            throw new IllegalArgumentException("내용은 30000자 이내로 작성해주세요.");
        }

        // 잘못된 카테고리가 온 경우에 예외 발생
        if (postDto.getCategory() == null
                || postDto.getCategory().isBlank()
                || !(
                postDto.getCategory().equals("all")
                        || postDto.getCategory().equals("qna")
                        || postDto.getCategory().equals("solution")
                        || postDto.getCategory().equals("problem")
        )
        ) {
            throw new IllegalArgumentException("잘못된 카테고리입니다.");
        }

        MemberDto loginMember = (MemberDto) session.getAttribute(SessionConst.LOGIN_USER);
        postDto.setMemberId(loginMember.getMemberId());

        Long postId = communityService.insertPost(postDto);

        List<PostDto> temporaryPostList = communityService.selectTemporaryPostList(postDto.getMemberId());

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
