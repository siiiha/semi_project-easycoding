package com.semi.easycoding.mapper;

import com.semi.easycoding.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

    MemberDto memberList(String memberId);
    MemberDto login(MemberDto memberDto);
    //MemberDto 안에 이미 private String email과 private String password가 들어있다.

    int join(MemberDto memberDto);
    //회원정보가 담긴 memberDto를 받고, DB처리 결과를 숫자로 돌려주는 join()메서드

}
