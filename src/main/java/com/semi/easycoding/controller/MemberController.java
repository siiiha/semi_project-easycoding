package com.semi.easycoding.controller;

import com.semi.easycoding.dto.MemberDto;
import com.semi.easycoding.service.MemberService;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;
    //회원목록 조회
    //요청 : Get/member/list
    //파라미터 X
    //결과 : 회원목록 페이지 포워딩


    //회원가입
    @GetMapping("/join")   //회원가입을 보여주는 곳
    public String join() {
        return "member/join"; //이 화면을 보여줘!!
    }

    //사용자가 입력한 정보를 받는다.
    @PostMapping("/join")
    public String join(MemberDto memberDto, //email, nickname, password가 있음
                       @RequestParam String passwordConfirm, //passwordConfirm : 두 번째 비밀번호 확인
                       Model model){

        //memberDto.getPassword() : 첫 번째 비밀번호
        //passwordConfirm : 두 번째 비밀번호 확인
        //Model : 서로 다를 때 화면에 오류 문구를 전달한다.
        if(!memberDto.getPassword().equals(passwordConfirm)) {
            model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
            return "member/join";
        }
        //위는 비밀번호가 일치하지 않을 경우. 아래는 일치할 경우.
        //회원이 추가되면 1, 추가되지 않으면 0
        int result = memberService.join(memberDto);
        //회원가입 처리 숫자를 담는다.
        return "redirect:/member/login";
    }


    @GetMapping("/login") //로그인을 보여주는 곳
    public String login(){
        return "member/login";
    }

    @PostMapping("/login")
    public String login(MemberDto memberDto, HttpSession session, Model model){

        MemberDto loginMember = memberService.login(memberDto);
        //호출!

        if(loginMember != null){
            session.setAttribute("loginUser", loginMember);
            return "redirect:/";
            //DB에서 일치하는 회원을 찾아 loginMember가 null이 아니라면,
            //그 회원정보를 loginUser라는 이름으로 세션에 저장하고 메인 주소로 이동
        }
        model.addAttribute("errorMsg", "이메일 또는 비밀번호가 올바르지 않습니다.");
        return "member/login";  //이메일과 비밀번호가 올바르지 않을 때는 로그인 화면으로 다시 이동

    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
        //작업이 끝났으니 메인 페이지로 가라.

    }

    @GetMapping("/list")
    public String list(@RequestParam String memberId, Model model, HttpSession session){

        MemberDto memberdto = memberService.memberList(memberId);
        model.addAttribute("memberInfo", memberdto);
        session.setAttribute("loginUser", memberdto);


        return "/mypage/mypage";
    }

}

//그럼 앞으로
//- 코드는 내가 작성
//- 초보자에게 알려주는 듯이 한단계씩 설명
//- 내가 스스로 작성할 수 있게 해야함
//- 현재 로그인 로그아웃 회원가입 기능을 만들 것