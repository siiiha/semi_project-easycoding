package com.semi.easycoding.community.mapper;

import com.semi.easycoding.community.dto.PostDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommunityMapper {

    List<PostDto> selectPostList();

}
