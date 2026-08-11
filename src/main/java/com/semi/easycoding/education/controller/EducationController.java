package com.semi.easycoding.education.controller;

import com.semi.easycoding.education.dto.*;
import com.semi.easycoding.common.util.SessionUtil;
import com.semi.easycoding.education.service.EducationService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    private final EducationService educationService;

    public EducationController(EducationService educationService) {
        this.educationService = educationService;
    }

    // ---- 페이지 이동을 위한 메소드 ----

    // 일일 학습 페이지 이동
    @GetMapping("/daily")
    public String dailyQuizPage(HttpSession session, Model model){

        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = SessionUtil.getLoginMemberId(session);
        
        List<MemberQuizHistoryDto> todayEducationHistory = educationService.todayEducations(memberId);
        model.addAttribute("todayEducationHistory", todayEducationHistory);

        return "education/daily";
    }

    @GetMapping("/daily/quiz")
    public String mainQuizPage(HttpSession session, Model model){

        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = SessionUtil.getLoginMemberId(session);

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
        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = SessionUtil.getLoginMemberId(session);

        boolean result = educationService.submitDailyAnswerByOption(submitDto, memberId);

        return result ? "성공" : "실패";

    }

    @GetMapping("/daily/complete")
    public String DailyCompletePage(HttpSession session, Model model){

        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = SessionUtil.getLoginMemberId(session);

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
    public String categoryPage(HttpSession session, RedirectAttributes redirectAttributes) {
        Long memberId = SessionUtil.getLoginMemberId(session);

        if (!educationService.isTodayAllClear(memberId)) {
            redirectAttributes.addFlashAttribute("modalTitle", "안내");
            redirectAttributes.addFlashAttribute("modalMessage", "남은 문제를 다 풀어야 추가 문제를 받을 수 있어요.");
            redirectAttributes.addFlashAttribute("modalTheme", "warning");
            return "redirect:/education/daily";
        }

        return "education/category";
    }

    @GetMapping("/category/quiz")
    public String categoryListPage(@RequestParam("categoryId") Short categoryId,
                                   HttpSession session,
                                   Model model) {
        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = SessionUtil.getLoginMemberId(session);

        List<EducationDto> educationListByCategory = educationService.getNotAssignedEducationsByCategoryWithAnswers(memberId, 1, categoryId);

        model.addAttribute("educations", educationListByCategory);

        return "education/category_quiz";
    }

    @GetMapping("/review")
    public String reviewPage(HttpSession session,
                             Model model){
        // 받아온 세션에서 memberID 꺼내서 Long타입으로 변환
        Long memberId = SessionUtil.getLoginMemberId(session);

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
