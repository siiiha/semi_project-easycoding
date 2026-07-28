package com.semi.easycoding.community.controller;

import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.community.dto.PostListResult;
import com.semi.easycoding.community.dto.PostSearchCondition;
import com.semi.easycoding.community.service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        System.out.println("요청 들어옴");
        System.out.println(condition.getPage());
        PostListResult result = communityService.selectPostList(condition);

        // 이번 요청에서만 사용할 것이기 때문에 request영역에 "postList"라는 이름으로 DB에서 조회한 게시글 목록을 저장
        model.addAttribute("postList", result.getPostList());
        model.addAttribute("pageInfo", result.getPageInfo());
        model.addAttribute("condition", condition);

        return "/community/community_list";
    }

    @GetMapping("/write")
    public String writePage(){
        return "/community/community_write";
    }

}
