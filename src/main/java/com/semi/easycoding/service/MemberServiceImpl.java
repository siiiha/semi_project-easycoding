package com.semi.easycoding.service;

import com.semi.easycoding.dto.MemberDto;
import com.semi.easycoding.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;
    //Mapper에게 DB조회 요청!


    @Override    //MemberService 설명서에 선언된 join() 메서드를 여기서 구현
    public int join(MemberDto memberDto){
        //회원정보 memberDto를 받아서, join메서드를 통해 마지막에 숫자를 돌려준다.
        return memberMapper.join(memberDto);
        //서비스가 받은 회원 정보를 MemberMapper에 반환. 회원가입이 성공했는지 알려준다. 1로~
    }


    @Override
    public MemberDto login(MemberDto memberDto){
        MemberDto loginMember = memberMapper.login(memberDto);
        return loginMember;
    }

    @Override
    public MemberDto memberList(String memberId) {
        MemberDto memberdto =  memberMapper.memberList(memberId);

        return memberdto;
    }

}