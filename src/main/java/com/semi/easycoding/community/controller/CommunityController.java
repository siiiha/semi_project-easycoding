package com.semi.easycoding.community.controller;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        try {
            if (condition.getPage() < 1 || condition.getPageSize() > 10) {
                throw new IllegalArgumentException("잘못된 접근입니다.");
            }

            if (condition.getPostCategory() == null
                    || condition.getPostCategory().isBlank()) {
                condition.setPostCategory("all");
            }

            PostListResult result = communityService.selectPostList(condition);
            // 이번 요청에서만 사용할 것이기 때문에 request영역에 "postList"라는 이름으로 DB에서 조회한 게시글 목록을 저장
            model.addAttribute("postList", result.getPostList());
            model.addAttribute("pageInfo", result.getPageInfo());
            model.addAttribute("condition", condition);

            for (PostDto postDto : result.getPostList()) {
                switch (postDto.getCategory()) {
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
        } catch (IllegalArgumentException e) {
            model.addAttribute("errMsg", e.getMessage());
            return "common/error";
        }

        return "community/community_list";
    }

    // 게시글 상세 조회 및 상세페이지 이동
    @GetMapping("/detail/{postId}")
    public String postDetailPage(
            PostSearchCondition condition,
            @PathVariable Long postId,
            Model model) {
        try {
            PostDto postDetail = communityService.selectPostDetail(postId);
            model.addAttribute("postDetail", postDetail);
        } catch (IllegalArgumentException | IllegalStateException e) {
            // 등록되지 않은 게시글 인 경우, error페이지로 이동
            model.addAttribute("errMsg", e.getMessage());
            return "common/error";
        }
        String postCategory =  condition.getPostCategory();
        if (postCategory == null || postCategory.isBlank()) {
            postCategory = "all";
        }
        String redirectURL = "/community?postCategory="
                + postCategory
                + "&page="
                + condition.getPage();
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
            RedirectAttributes redirectAttributes,
            Model model,
            HttpSession session
    ) {
        try {
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
            postDto.setMemberId(Long.valueOf( loginMember.getMemberId()));

            Long postId = communityService.insertPost(postDto);
            redirectAttributes.addFlashAttribute("successMsg", "게시글 작성 성공");
            return "redirect:/community/detail/" + postId;
        } catch (IllegalArgumentException e) {
            model.addAttribute("errMsg", e.getMessage());
            model.addAttribute("postDetail", postDto);
            return "community/community_write";
        } catch (IllegalStateException e) {
            model.addAttribute("errMsg", e.getMessage());
            return "common/error";
        }
    }

    // 게시글 번호(PK)를 가지고 게시글을 조회 및 수정페이지 이동
    @GetMapping("/{postId}/edit")
    public String editPage(
            @PathVariable Long postId,
            HttpSession session,
            Model model
    ) {
        MemberDto loginMember = (MemberDto) session.getAttribute(SessionConst.LOGIN_USER);
        Long memId = Long.valueOf(loginMember.getMemberId());
        try {
            PostDto postDetail = communityService.whenEditSelectPostDetail(postId);
            model.addAttribute("postDetail", postDetail);
            if (!postDetail.getMemberId().equals(memId)) {
                throw new IllegalArgumentException("수정 권한이 없거나 게시글이 존재하지 않습니다.");
            }
//            if (postDetail.getMemberId().equals(loginMember.getMemberId())) {
//                throw new IllegalArgumentException("수정 권한이 없거나 게시글이 존재하지 않습니다.");
//            }
        } catch (IllegalArgumentException e) {
            model.addAttribute("errMsg", e.getMessage());
            return "community/community_detail";
        }

        return "community/community_edit";
    }

    @PostMapping("/{postId}/edit")
    public String editPost(
            @ModelAttribute PostDto postDto,
            @PathVariable Long postId,
            RedirectAttributes redirectAttributes,
            Model model,
            HttpSession session
    ) {
        try {
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
            if (postDto.getCategory() == null || postDto.getCategory().isBlank()) {
                throw new IllegalArgumentException("잘못된 카테고리입니다.");
            }
            MemberDto loginMember = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);
            Long memId = Long.valueOf(loginMember.getMemberId());
            postDto.setPostId(postId);
            postDto.setMemberId(memId);

            Long editPostId = communityService.updatePost(postDto);
        } catch (IllegalArgumentException e) {
            model.addAttribute("postDetail", postDto);
            model.addAttribute("errMsg", e.getMessage());
            return "community/community_edit";
        } catch (IllegalStateException e) {
            model.addAttribute("postDetail", postDto);
            model.addAttribute("errMsg", e.getMessage());
            return "common/error";
        }

        redirectAttributes.addFlashAttribute("successMsg", "게시글 수정 성공");
        return "redirect:/community/detail/" + postId;
    }
  
    @PostMapping("/{postId}/delete")
    public String deletePost(
            @PathVariable Long postId,
            RedirectAttributes redirectAttributes,
            Model model,
            HttpSession session
    ) {
        MemberDto loginMember = (MemberDto)session.getAttribute(SessionConst.LOGIN_USER);
        try {
            communityService.deletePost(postId, loginMember.getMemberId());
        } catch (IllegalStateException e) {
            model.addAttribute("errMsg", e.getMessage());
            return "common/error";
        }

        redirectAttributes.addFlashAttribute("successMsg", "게시글 삭제 성공");
        return "redirect:/community";
    }

}
