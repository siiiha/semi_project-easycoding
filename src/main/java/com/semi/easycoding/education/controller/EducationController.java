package com.semi.easycoding.education.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/education")
public class EducationController {

    // ---- 페이지 이동을 위한 메소드 ----

    // 일일 학습 페이지 이동
    @GetMapping("/daily-quiz")
    public String dailyQuizPage(){
        return "/education/daily_quiz";
    }

    // 카테고리 학습 페이지 이동
    @GetMapping("/category")
    public String categoryPage(){
        return "/education/category";
    }

}
