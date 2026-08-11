package com.semi.easycoding.education.controller;

import com.semi.easycoding.education.dto.*;
import com.semi.easycoding.education.service.EducationService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/education")
public class EducationController {

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

        // 모든 문제가 이미 제출된 상태라면 (모든 answered가 true) "/daily/complete" 페이지로 이동
        List<MemberQuizHistoryDto> todayEducationHistory = educationService.todayEducations(memberId);
        boolean allSubmitted = todayEducationHistory.stream()
                .allMatch(history -> history.isAnswered());
        if (allSubmitted) {
            return "redirect:/education/daily/complete";
        }

        List<EducationDto> todayEducation = educationService.getTodayEducationsNotSubmitted(memberId);
        model.addAttribute("todayEducation", todayEducation);

        return "education/daily_quiz";
    }

    @ResponseBody
    @PostMapping("/submit")
    public String submitDailyAnswer(@RequestBody EducationOptionSubmitDto submitDto,
                                                  HttpSession session) {

        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        Long memberId = Long.valueOf(loginUser.getMemberId());

        boolean result = educationService.submitDailyAnswerByOption(submitDto, memberId);

        return result ? "성공" : "실패";

    }

    @GetMapping("/daily/complete")
    public String DailyCompletePage(HttpSession session, Model model){

        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        Long memberId = Long.valueOf(loginUser.getMemberId());

        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime endOfToday = LocalDate.now().atTime(LocalTime.MAX);
        EducationSummaryDto summary = educationService.makeEducationSummary(memberId, startOfToday, endOfToday);
        int streakDays = educationService.countStreakDay(memberId);

        model.addAttribute("summary", summary);
        model.addAttribute("streakDays", streakDays);

        return "education/daily_quiz_complete";
    }

    // 카테고리 학습 페이지 이동
    @GetMapping("/category")
    public String categoryPage(){
        return "education/category";
    }

    @GetMapping("/category/quiz")
    public String categoryListPage(@RequestParam("categoryId") Short categoryId,
                                   HttpSession session,
                                   Model model) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        Long memberId = Long.valueOf(loginUser.getMemberId());

        List<EducationDto> educationListByCategory = educationService.getNotAssignedEducationsByCategoryWithAnswers(memberId, 1, categoryId);

        model.addAttribute("educations", educationListByCategory);

        return "education/category_quiz";
    }

    @GetMapping("/review")
    public String reviewPage(HttpSession session,
                             Model model){
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        Long memberId = Long.valueOf(loginUser.getMemberId());

        LocalDateTime startDate = LocalDate.now().atStartOfDay();
        LocalDateTime endDate = LocalDate.now().atTime(LocalTime.MAX);

        List<EducationOptionTypeSubmitDto> submittedList = educationService.getSubmittedEducationDtoAtDate(memberId, startDate, endDate);
        model.addAttribute("submittedList", submittedList);

        return "education/review";
    }


    @GetMapping("/test")
    public String test() {
        return "test/test";
    }





}
