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
  
    int deletePost(Long postId, Long memberId);

}
