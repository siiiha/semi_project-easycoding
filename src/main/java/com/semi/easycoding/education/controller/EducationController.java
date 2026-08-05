package com.semi.easycoding.education.controller;

import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.MemberQuizHistoryDto;
import com.semi.easycoding.education.service.EducationService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/education")
public class EducationController {

    @Value("${spring.ai.openai.api-key}")
    String apiKey;

    EducationService educationService;

    public EducationController(EducationService educationService) {
        this.educationService = educationService;
    }

    // ---- 페이지 이동을 위한 메소드 ----

    // 일일 학습 페이지 이동
    @GetMapping("/daily")
    public String dailyQuizPage(HttpSession session, Model model){
        // 비로그인시, 로그인쪽으로 리다이렉팅
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if(loginUser == null){
            return "redirect:/member/login";
        }

        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = Long.valueOf(loginUser.getMemberId());
        
        List<MemberQuizHistoryDto> todayEducationHistory = educationService.todayEducations(memberId);
        model.addAttribute("todayEducationHistory", todayEducationHistory);

        return "education/daily";
    }

    @GetMapping("/daily/quiz")
    public String mainQuizPage(HttpSession session, Model model){
        // 비로그인시, 로그인쪽으로 리다이렉팅
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if(loginUser == null){
            return "redirect:/member/login";
        }

        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = Long.valueOf(loginUser.getMemberId());

        List<EducationDto> todayEducation = educationService.getTodayEducationsNotSubmitted(memberId);
        model.addAttribute("todayEducation", todayEducation);

        return "education/daily_quiz";
    }

    // 카테고리 학습 페이지 이동
    @GetMapping("/category")
    public String categoryPage(){
        return "education/category";
    }

    @GetMapping("/test")
    public String test() {
        return "test/test";
    }





}
