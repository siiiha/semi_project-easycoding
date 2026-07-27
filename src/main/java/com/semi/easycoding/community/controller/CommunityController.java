package com.semi.easycoding.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/community")
public class CommunityController {

    // ---- 페이지 이동을 위한 메소드 ----

    // 커뮤니티 페이지
    @GetMapping("")
    public String qnaPage(){
        return "/community/community_list";
    }

    @GetMapping("/write")
    public String writePage(){
        return "/community/community_write";
    }

}
