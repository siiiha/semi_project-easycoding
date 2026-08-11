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


    // 로그인 성공 시 비밀번호가 없는 회원 정보를 반환한다.
    @Override
    public MemberDto login(MemberDto memberDto) {
        MemberDto loginMember = memberMapper.login(memberDto);

        if (loginMember == null) {
            return null;
        }

        boolean passwordMatches = passwordEncoder.matches(
                memberDto.getPassword(),
                loginMember.getPassword()
        );
        if (!passwordMatches) {
            return null;
        }

        return memberMapper.findByMemberId(loginMember.getMemberId());
    }

    @Override
    public MemberDto findByMemberId(Long memberId) {
        return memberMapper.findByMemberId(memberId);
    }

    // 일반 회원정보 조회 시 비밀번호는 포함하지 않는다.

    @Override
    public int updateNickname(Long memberId, String nickname) {
        String trimmedNickname = nickname.trim();

        return memberMapper.updateNickname(memberId, trimmedNickname);
    }

    @Override
    public int countPostByMemberId(Long memberId) {
        return memberMapper.countPostByMemberId(memberId);
    }

    @Override
    public int countCommentByMemberId(Long memberId) {
        return memberMapper.countCommentByMemberId(memberId);
    }

    // 회원 탈퇴 시 암호화된 비밀번호만 별도로 조회하여 사용한다.
    @Override
    public boolean withdraw(Long memberId, String password) {
        String encodedPassword =
                memberMapper.findPasswordByMemberId(memberId);

        if (encodedPassword == null) {
            return false;
        }

        boolean passwordMatches =
                passwordEncoder.matches(
                        password,
                        encodedPassword
                );

        if (!passwordMatches) {
            return false;
        }

        int result = memberMapper.withdraw(memberId);
        return result > 0;
    }

    @Override
    public boolean resetPassword(
            String email,
            String newPassword
    ) {
        String encodedPassword = passwordEncoder.encode(newPassword);

        int result = memberMapper.updatePasswordByEmail(
                email,
                encodedPassword
        );
        return result > 0;
    }

    @Override
    public boolean updatePassword(
            Long memberId,
            String currentPassword,
            String newPassword
    ) {
        String savedPassword =
                memberMapper.findPasswordByMemberId(memberId);

        if (savedPassword == null) {
            return false;
        }

        if (!passwordEncoder.matches(currentPassword, savedPassword)) {
            return false;
        }

        String encodedPassword = passwordEncoder.encode(newPassword);

        int result = memberMapper.updatePasswordByMemberId(
                memberId,
                encodedPassword
        );

        return result > 0;
    }

    @Override
    public int updateProfileId(Long memberId, Short profileId) {
        if (profileId == null
                || profileId < 1
                || profileId > 6) {
            throw new IllegalArgumentException(
                    "올바르지 않은 프로필 이미지입니다."
            );
        }

        return memberMapper.updateProfileId(
                memberId,
                profileId
        );
    }
}
