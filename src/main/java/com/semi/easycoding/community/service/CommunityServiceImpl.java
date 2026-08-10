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

        // 전체 페이지 갯수
        int totalCount = communityMapper.selectPostCount(condition);

        // 페이징 정보를 계산하고, 저장하기 위한 PageInfo 객체 생성
        PageInfo pageInfo = new PageInfo(
                condition.getPage(),
                condition.getPageSize(),
                totalCount
        );


        // PageInfo에서 계산한 값을 검색조건 객체에 달아줌
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

        // 조회하는 게시글의 조회수 1증가
        int increseViews = communityMapper.increseViews(postId);
        if (increseViews <= 0) {
            return null;
        }

        PostDto postDetail = communityMapper.selectPostDetail(postId);
        if (postDetail == null) {
            return null;
        }

        return postDetail;
    }


     /** 게시글 작성 시 DB에 추가하고, 추가한 게시글의 PK를 반환받는 메소드
     * @return : PostDto의 postId
     */
    @Override
    public Long insertPost(PostDto postDto) {
        int category_id = communityMapper.selectCategoryId(postDto.getCategory());
        postDto.setCategoryId(category_id);
        int result = communityMapper.insertPost(postDto);
        if (result != 1) {
            return 0L;
        }

        return postDto.getPostId();
    }

    /**
     * 게시글 수정한 내용으로 DB에 저장하는 메소드
     * @return : int
     */
    @Override
    public Long updatePost(PostDto postDto) {
        int category_id = communityMapper.selectCategoryId(postDto.getCategory());
        postDto.setCategoryId(category_id);
        int result = communityMapper.updatePost(postDto);
        if (result != 1) {
            return 0L;
        }
        return postDto.getPostId();
    }
  
      /**
     * 게시글 삭제하는 메소드
     */
    @Override
    public int deletePost(Long postId, Long memberId) {


        int result = communityMapper.deletePost(postId, memberId);
        if (result <= 0) {
            // 실패 시 로직
        }
        // 성공 시 로직
        return result;
    }
}
