package com.semi.easycoding.community.controller;

import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.community.dto.PostListResult;
import com.semi.easycoding.community.dto.PostSearchCondition;
import com.semi.easycoding.community.service.CommunityService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


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

        String redirectURL = "/community?postCategory=" + condition.getPostCategory() + "&page=" + condition.getPage();
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
            Model model,
            HttpSession session
    ) {
        // 게시글 제목의 빈값 여부와 글자 수 제한을 통해 예외 발생
        if (postDto.getTitle() == null || postDto.getTitle().isBlank()) {
            model.addAttribute("errMsg", "제목을 입력하지 않았습니다.");
            return "redirect:/community/write";
        } else if (postDto.getTitle().length() > 85) {
            model.addAttribute("errMsg", "제목은 85자 이내로 작성해주세요.");
        }

        // 게시글 내용의 빈값 여부와 글자 수 제한을 통해 예외 발생
        if (postDto.getContent() == null || postDto.getContent().isBlank()) {
            model.addAttribute("errMsg", "내용을 입력해주세요.");
        } else if (postDto.getContent().length() > 30000) {
            model.addAttribute("errMsg", "내용은 30000자 이내로 작성해주세요.");
        }

        // 잘못된 카테고리가 온 경우에 예외 발생
        if (postDto.getCategory() == null || postDto.getCategory().isBlank()) {
            model.addAttribute("errMsg", "잘못된 카테고리입니다.");
        }

        MemberDto loginMember = (MemberDto) session.getAttribute("loginUser");
        postDto.setMemberId(loginMember.getMemberId());

        // TODO: 추가적으로 아래에 service함수의 결과 값을 통해서 redirect detail로 하거나 에러 페이지로 redirect시키기
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

}
