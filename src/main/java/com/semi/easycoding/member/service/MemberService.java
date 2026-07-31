package com.semi.easycoding.member.service;

import com.semi.easycoding.member.dto.MemberDto;

public interface MemberService {

    MemberDto login(MemberDto memberDto);
    //email과 password를 담았다.

    boolean isEmailDuplicate(String email);
    //이메일 중복 여부를 확인 (true:이미 사용중. false:사용가능한이메일

    boolean isNicknameDuplicate(String nickname);

    MemberDto memberList(String memberId);

    int join(MemberDto memberDto);
    //회원가입 메서드의 사용 규칙을 정하는 것!
    //읽어보면 조인 메서드는 MemberDto라는 자료형의 값을 memberDto라는 이름으로 받아서
    //처리 결과는 int값으로 돌려주겠다! 그것이 join메서드다~

    //멤버 컨트롤러에서 사용된 int result = memberService.join(memberDto);에 관련된 메소드로
    //받은 값이 1이면 DB에 회원 한 행이 추가, 0이면 추가가 된 행이 없다.

    int countPostByMemberId(String memberId);
    int countCommentByMemberId(String memberId);

    boolean withdraw(String memberId, String password);


    int updateNickname(String memberId, String nickname);


}
