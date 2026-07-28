package com.semi.easycoding.community.dto;

import com.semi.easycoding.common.dto.PageInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class PostListResult {
    private List<PostDto> postList;
    private PageInfo pageInfo;
}
