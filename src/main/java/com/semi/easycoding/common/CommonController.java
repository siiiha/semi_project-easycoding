package com.semi.easycoding.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {



    // 서비스 소개 & 학습 가이드 페이지 이동
    @GetMapping("service/guide")
    public String guidePage(){
        return "service/intro";
    }

    // 문의하기 페이지 이동
    @GetMapping("/inquiry")
    public String inquiryPage(){
        return "service/inquiry";
    }

}
