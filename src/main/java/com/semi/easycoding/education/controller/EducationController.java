package com.semi.easycoding.education.controller;

import com.semi.easycoding.common.util.SessionConst;
import com.semi.easycoding.education.dto.EducationDto;
import com.semi.easycoding.education.dto.MemberQuizHistoryDto;
import com.semi.easycoding.education.service.EducationService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/education")
public class EducationController {

    @Value("${spring.ai.openai.api-key}")
    String apiKey;

    private final EducationService educationService;

    public EducationController(EducationService educationService) {
        this.educationService = educationService;
    }

    // ---- 페이지 이동을 위한 메소드 ----

    // 일일 학습 페이지 이동
    @GetMapping("/daily")
    public String dailyQuizPage(HttpSession session, Model model){
        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = getLoginMemberId(session);
        
        List<MemberQuizHistoryDto> todayEducationHistory = educationService.todayEducations(memberId);
        model.addAttribute("todayEducationHistory", todayEducationHistory);

        return "education/daily";
    }

    @PostMapping("/daily/quiz/start")
    public String startDailyQuiz(
            @RequestParam int problemCount,
            @RequestParam(required = false) Long categoryId,
            HttpSession session, RedirectAttributes redirectAttributes) {
        Long memberId = getLoginMemberId(session);

        try {
            educationService.prepareDailyQuiz(memberId, problemCount, categoryId);
        } catch (IllegalArgumentException exception) {
            redirectAttributes.addFlashAttribute(
                    "missionError",
                    exception.getMessage()
            );
            return "redirect:/";
        }

        return "redirect:/education/daily/quiz";
    }

    @GetMapping("/daily/quiz")
    public String mainQuizPage(HttpSession session, Model model){

        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = getLoginMemberId(session);

        List<EducationDto> todayEducation = educationService.getTodayEducations(memberId);
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

    // 세션에서 로그인 회원의 ID를 꺼내 반환
    private Long getLoginMemberId(HttpSession session) {
        MemberDto loginUser =
                (MemberDto) session.getAttribute(SessionConst.LOGIN_USER);

        return Long.valueOf(loginUser.getMemberId());
    }


}
