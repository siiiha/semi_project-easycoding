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
    int selectPostCount();

    PostDto selectPostDetail(Long postId);
}
