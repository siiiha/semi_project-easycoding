package com.semi.easycoding.community.service;

import com.semi.easycoding.common.dto.PageInfo;
import com.semi.easycoding.community.dto.PostDto;
import com.semi.easycoding.community.dto.PostListResult;
import com.semi.easycoding.community.dto.PostSearchCondition;
import com.semi.easycoding.community.mapper.CommunityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommunityServiceImpl implements CommunityService {

    // Service에서 CommunityMapper를 사용할때마다 spring이 생성할 수 있도록 bean에 등록
    @Autowired
    private CommunityMapper communityMapper;


    /**
     * 게시판 이동 시 게시글 조회하는 메소드
     * @return : List<PostDto> 게시글 리스트
     */
    @Override
    public PostListResult selectPostList(PostSearchCondition condition) {

        int totalCount = communityMapper.selectPostCount();

        PageInfo pageInfo = new PageInfo(
                condition.getPage(),
                condition.getPageSize(),
                totalCount
        );

        condition.setOffset(pageInfo.getOffset());
        condition.setLimit(pageInfo.getLimit());

        List<PostDto> postList = communityMapper.selectPostList(condition);
        return new PostListResult(postList, pageInfo);
    }

    /**
     * 게시글 상세 조회 시 상세정보 조회하는 메소드
     * @return : PostDto 게시글 1개
     */
    @Override
    public PostDto selectPostDetail(Long postId) {

        PostDto postDetail = communityMapper.selectPostDetail(postId);

        return postDetail;
    }

    /**
     * 게시글 작성 시 DB에 추가하고, 추가한 게시글의 PK를 반환받는 메소드
     * @return : PostDto의 postId
     */
    @Override
    public Long insertPost(PostDto postDto) {
        PostDto post = communityMapper.insertPost(postDto);
        Long postId = post.getPostId();

        return postId;
    }
}
