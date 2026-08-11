package com.semi.easycoding.community.service;

import com.semi.easycoding.community.dto.*;

import java.util.List;

public interface CommunityService {

    List<PopularMemberDto> selectPopularMember();

    PostListResult selectPostList(PostSearchCondition condition);

    PostDto selectPostDetail(Long postId);

    PostDto whenEditSelectPostDetail(Long postId);

    Long insertPost(PostDto postDto);
    Long temporarySavePost(SaveTemporaryPostDto temporaryPostDto, Long memberId);

    Long updatePost(PostDto postDto);

    void deletePost(Long postId, Long memberId);

    List<PostDto> selectTemporaryPostList(Long memberId);
}
