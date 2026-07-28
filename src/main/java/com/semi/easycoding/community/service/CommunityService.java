package com.semi.easycoding.community.service;

import com.semi.easycoding.community.dto.PostDto;

import java.util.List;

public interface CommunityService {

    List<PostDto> selectPostList();
}
