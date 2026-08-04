package com.semi.easycoding.member.mapper;
//MemberMapper는 인터페이스!

import com.semi.easycoding.member.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
//MyBatis가 제공하는 @Param 어노테이션을 사용하겠다.

@Mapper
public interface MemberMapper {

    MemberDto memberList(String memberId);

    MemberDto login(MemberDto memberDto);
    //MemberDto 안에 이미 private String email과 private String password가 들어있다.

    int countByEmail(String email);
    //DB에서 찾은 이메일의 갯수를 int값으로 알려준다.
    //countByEmail은 이메일을 기준으로 개수를 센다는 뜻이다.

    int join(MemberDto memberDto);
    //회원정보가 담긴 memberDto를 받고, DB처리 결과를 숫자로 돌려주는 join()메서드

    int countPostByMemberId(String memberId);
    int countCommentByMemberId(String memberId);

    int withdraw(@Param("memberId") String memberId);
    //loginUser.getMemberId() = 실제 로그인한 회원번호

    int updatePasswordByEmail(
            @Param("email") String email,
            @Param("password") String password
    );
}
