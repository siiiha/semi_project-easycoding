package com.semi.easycoding.community.controller;

import com.semi.easycoding.comment.dto.CommentDto;
import com.semi.easycoding.common.dto.ApiResponse;
import com.semi.easycoding.common.util.SessionConst;
import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.community.dto.PostListResult;
import com.semi.easycoding.community.dto.PostSearchCondition;
import com.semi.easycoding.community.service.CommunityService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;


    // ---- 페이지 이동을 위한 메소드 ----

    // 커뮤니티 페이지 이동 및 데이터 조회
    @GetMapping("")
    public String communityPage(
            @ModelAttribute PostSearchCondition condition,
            Model model) {


        if (condition.getPostCategory() == null
        || condition.getPostCategory().equals("")) {
            condition.setPostCategory("all");
        }

        PostListResult result = communityService.selectPostList(condition);
        // 이번 요청에서만 사용할 것이기 때문에 request영역에 "postList"라는 이름으로 DB에서 조회한 게시글 목록을 저장
        model.addAttribute("postList", result.getPostList());
        model.addAttribute("pageInfo", result.getPageInfo());
        model.addAttribute("condition", condition);
        System.out.println(condition.getKeyword());

        for (PostDto postDto : result.getPostList()) {
            switch(postDto.getCategory()) {
                case "qna":
                    postDto.setCategory("질문&답변");
                    break;
                case "solution":
                    postDto.setCategory("풀이공유");
                    break;
                case "problem":
                    postDto.setCategory("문제제작");
                    break;
                default:
                    postDto.setCategory("전체");
            }
        }

        return "community/community_list";
    }

    // 게시글 상세 조회 및 상세페이지 이동
    @GetMapping("/detail/{postId}")
    public String postDetailPage(
            PostSearchCondition condition,
            @PathVariable Long postId,
            Model model) {
        PostDto postDetail = communityService.selectPostDetail(postId);
        model.addAttribute("postDetail", postDetail);
        System.out.println(postDetail.getViews());

        String redirectURL = "/community?postCategory=all&page=" + condition.getPage();
//        String redirectURL = "/community?postCategory=" + condition.getPostCategory + "&page=" + condition.getPage();
        model.addAttribute("redirectURL", redirectURL);

        return "community/community_detail";
    }

    @GetMapping("/write")
    public String writePage(){
        return "community/community_write";
    }

    @PostMapping("/write")
    public String writePost(
            @ModelAttribute PostDto postDto,
            HttpSession session
    ) {
        MemberDto loginMember = (MemberDto) session.getAttribute("loginUser");
        System.out.println(loginMember != null);
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        postDto.setMemberId(loginMember.getMemberId());

        // 임시 저장 불러온 후에 게시글 등록 하는 경우 : postDto의 postId가 있음
        System.out.println("게시글 작성 시 postId있는지 : " + postDto.getPostId() );
        if (postDto.getPostId() != null) {
            Long postId = communityService.insertTemporaryPost(postDto);
        }

        Long postId = communityService.insertPost(postDto);

        return "redirect:/community/detail/" + postId;
    }

    // 게시글 번호(PK)를 가지고 게시글을 조회 및 수정페이지 이동
    @GetMapping("/{postId}/edit")
    public String editPage(
            @PathVariable Long postId,
            Model model
    ) {
        PostDto postDetail = communityService.selectPostDetail(postId);
        model.addAttribute("postDetail", postDetail);

        return "community/community_edit";
    }

    @PostMapping("/{postId}/edit")
    public String editPost(
            @ModelAttribute PostDto postDto,
            @PathVariable Long postId
    ) {
        postDto.setPostId(postId);
        Long editPostId = communityService.updatePost(postDto);

        return "redirect:/community/detail/" + editPostId ;
    }
  
    @PostMapping("/{postId}/delete")
    public String deletePost(
            @PathVariable Long postId,
            HttpSession session
    ) {
        MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
        communityService.deletePost(postId, loginUser.getMemberId());

        return "redirect:/community";
    }

    @ResponseBody
    @GetMapping("/temporary/post")
    public ResponseEntity<ApiResponse<List<PostDto>>> temporaryPost(
            Model model,
            HttpSession session
    ) {
        MemberDto loginMember = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);
        List<PostDto> temporaryPostList = communityService.selectTemporaryPost(loginMember.getMemberId());
        model.addAttribute("temporaryPostList", temporaryPostList);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(temporaryPostList));
    }



}
