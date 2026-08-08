package com.semi.easycoding.community.mapper;

import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.community.dto.PostSearchCondition;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommunityMapper {

    // 게시글 조회
    List<PostDto> selectPostList(PostSearchCondition condition);

    // 전체 게시글의 갯수를 조회
    int selectPostCount(PostSearchCondition condition);

    // 게시글 상세 조회
    PostDto selectPostDetail(Long postId);

    // 게시글의 조회수 변경
    int increseViews(Long postId);

    int insertPost(PostDto postDto);

    int selectCategoryId(String category);

    // 게시글 수정
    int updatePost(PostDto postDto);
  
    int deletePost(Long postId, String memberId);

    // 회원의 임시저장 게시물 정보를 조회
    List<PostDto> selectTemporaryPost(String memberId);

    // 임시저장한 게시글을 등록 (실제로는 update)
    int insertTemporaryPost(PostDto postDto);
}
