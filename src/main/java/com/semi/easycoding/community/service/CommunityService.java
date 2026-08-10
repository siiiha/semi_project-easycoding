package com.semi.easycoding.community.service;

import com.semi.easycoding.community.dto.PopularMemberDto;
import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.community.dto.PostListResult;
import com.semi.easycoding.community.dto.PostSearchCondition;

import java.util.List;

public interface CommunityService {

    List<PopularMemberDto> selectPopularMember();

    PostListResult selectPostList(PostSearchCondition condition);

    PostDto selectPostDetail(Long postId);

    PostDto whenEditSelectPostDetail(Long postId);

    Long insertPost(PostDto postDto);

    Long updatePost(PostDto postDto);

    void deletePost(Long postId, Long memberId);

    List<PostDto> selectTemporaryPostList(Long memberId);

    Long insertTemporaryPost(PostDto postDto);
}
