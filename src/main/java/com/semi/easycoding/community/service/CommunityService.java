package com.semi.easycoding.community.service;

import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.community.dto.PostListResult;
import com.semi.easycoding.community.dto.PostSearchCondition;

import java.util.List;

public interface CommunityService {

    PostListResult selectPostList(PostSearchCondition condition);

    PostDto selectPostDetail(Long postId);

    Long insertPost(PostDto postDto);
}
