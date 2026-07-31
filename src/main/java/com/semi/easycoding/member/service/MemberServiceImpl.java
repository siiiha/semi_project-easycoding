package com.semi.easycoding.member.service;

import com.semi.easycoding.member.dto.MemberDto;
import com.semi.easycoding.member.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private MemberMapper memberMapper;
    //Mapper에게 DB조회 요청!

    @Override
    public boolean isEmailDuplicate(String email) {
        return memberMapper.countByEmail(email) > 0;
    }
    //조회된 이메일의 개수가 1이면 결과값이 true로 이미 사용중인 이메일이라는 것.

    @Override
    public boolean isNicknameDuplicate(String nickname) {
        return memberMapper.countByNickname(nickname) > 0;
    }

    @Override    //MemberService 설명서에 선언된 join() 메서드를 여기서 구현
    public int join(MemberDto memberDto) {

        //비밀번호는 항상 암호화해서 저장.
        String encodePwd = passwordEncoder.encode(memberDto.getPassword());
        memberDto.setPassword(encodePwd);

        //회원정보 memberDto를 받아서, join메서드를 통해 마지막에 숫자를 돌려준다.
        return memberMapper.join(memberDto);
        //서비스가 받은 회원 정보를 MemberMapper에 반환. 회원가입이 성공했는지 알려준다. 1로~
    }


    @Override
    public MemberDto login(MemberDto memberDto) {
        MemberDto loginMember = memberMapper.login(memberDto);

        if (loginMember == null) {
            return null;
        }

        boolean passwordMatches = passwordEncoder.matches(
                memberDto.getPassword(),
                loginMember.getPassword());
        if (!passwordMatches) {
            return null;
        }

        return loginMember;
    }

    @Override
    public MemberDto findByMemberId(String memberId) {
        return memberMapper.findByMemberId(memberId);
    }
    //1. 회원탈퇴를 할 때 DB에서 회원정보와 암호화된 비밀번호를 가져온다.
    //2. 닉네임을 수정하고 최신 회원 정보를 가져온다.

    @Override
    //반환형 int는 DB에서 수정된 행의 개수
    public int updateNickname(String memberId, String nickname) {
        String trimmedNickname = nickname.trim();

        return memberMapper.updateNickname(memberId, trimmedNickname);
    }

    @Override
    public int countPostByMemberId(String memberId) {
        return memberMapper.countPostByMemberId(memberId);
    }

    @Override
    public int countCommentByMemberId(String memberId) {
        return memberMapper.countCommentByMemberId(memberId);
    }

    @Override
    public boolean withdraw(String memberId, String password) {
        MemberDto member = memberMapper.findByMemberId(memberId);
        if (member == null) {
            return false;
        }
        boolean passwordMatcheds =
                passwordEncoder.matches(
                        password,
                        member.getPassword()
                );
        if (!passwordMatcheds) {
            return false;
        }
        int result = memberMapper.withdraw(memberId);
        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }
}
