package com.semi.easycoding.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {

    // ---- 페이지 이동을 위한 메소드 ----

    // 로그인 페이지 이동
    @GetMapping("/login")
    public String loginPage(){
        return "/member/login";
    }

    // 회원가입 페이지 이동
    @GetMapping("/join")
    public String joinPage(){
        return "/member/join";
    }

    // 마이페이지 이동
    @GetMapping("/mypage")
    public String myPage(){
        return "/mypage/mypage";
    }

    // 회원정보 수정 페이지 이동
    @GetMapping("/edit")
    public String memberEditPage(){
        return "/mypage/edit";
    }

    // 회원탈퇴 페이지 이동
    @GetMapping("/withdraw")
    public String memberWithdrawPage(){
        return "/mypage/withdraw";
    }

}
