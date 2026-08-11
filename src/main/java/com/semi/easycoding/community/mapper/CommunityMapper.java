package com.semi.easycoding.community.mapper;

import com.semi.easycoding.community.dto.PopularMemberDto;
import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.community.dto.PostSearchCondition;
import com.semi.easycoding.community.dto.SaveTemporaryPostDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommunityMapper {

    // 인기 사용자 5위 조회
    List<PopularMemberDto> selectPopularMember();

    // 게시글 조회
    List<PostDto> selectPostList(PostSearchCondition condition);

    // 전체 게시글의 갯수를 조회
    int selectPostCount(PostSearchCondition condition);

    // 게시글 상세 조회
    PostDto selectPostDetail(Long postId);

    // 게시글의 조회수 변경
    int increaseViews(Long postId);

    int insertPost(PostDto postDto);
    int temporarySavePost(SaveTemporaryPostDto temporaryPostDto);

    int selectCategoryId(String category);

    // 게시글 수정
    int updatePost(PostDto postDto);
  
    int deletePost(Long postId, Long memberId);

    // 로그인한 회원의 임시저장 게시물 목록 정보를 조회
    List<PostDto> selectTemporaryPostList(Long memberId);

    // 임시저장한 게시글을 등록 (실제로는 update)
    int insertTemporaryPost(PostDto postDto);

    // 임시 저장하려는 게시글의 같은 정보로 있는지 확인
    boolean isDuplicatePost(PostDto temporarySavePost);
}
