package com.semi.easycoding.community.service;

import com.semi.easycoding.common.dto.PageInfo;
import com.semi.easycoding.community.dto.*;
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
     * 게시글 갯수를 통한 인기 회원 5위 조회
     * @return
     */
    @Override
    public List<PopularMemberDto> selectPopularMember() {
        return communityMapper.selectPopularMember();
    }

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

        PostDto postDetail = communityMapper.selectPostDetail(postId);
        if (postDetail == null) {
            throw new IllegalArgumentException("존재하지 않는 게시글 입니다.");
        }
        // 조회하는 게시글의 조회수 1증가
        int increaseViews = communityMapper.increaseViews(postId);
        if (increaseViews != 1) {
            throw new IllegalStateException("게시글 조회에 실패하였습니다.");
        } else {
            postDetail.setViews(postDetail.getViews() + 1);
        }

        return postDetail;
    }

    /**
     * 게시글 수정 시 해당 게시글 조회하는 메소드
     * @param postId
     * @return
     */
    @Override
    public PostDto whenEditSelectPostDetail(Long postId) {

        PostDto postDetail = communityMapper.selectPostDetail(postId);
        if (postDetail == null) {
            throw new IllegalArgumentException("존재하지 않는 게시글 입니다.");
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

        // 임시 저장한 글을 저장하는 경우 사실상 UPDATE
        if (postDto.getPostId() != null) {
            // 임시 저장 -> 등록
            int result = communityMapper.insertTemporaryPost(postDto);
            if (result != 1) {
                throw new IllegalStateException("게시글 작성을 실패했습니다.");
            }
        } else {
            // 최초 게시글 등록
            int result = communityMapper.insertPost(postDto);
            if (result != 1) {
                throw new IllegalStateException("게시글 작성을 실패했습니다.");
            }
        }

        return postDto.getPostId();
    }

    /** 게시글 임시 저장 시 DB에 추가하고, 추가한 게시글의 PK를 반환받는 메소드
     * @return : PostDto의 postId
     */
    @Override
    public Long temporarySavePost(SaveTemporaryPostDto temporaryPostDto, Long memberId) {
        int category_id = communityMapper.selectCategoryId(temporaryPostDto.getCategory());

        PostDto temporarySavePost = new  PostDto();
        temporarySavePost.setPostId(temporaryPostDto.getPostId());
        temporarySavePost.setCategoryId(category_id);
        temporarySavePost.setMemberId(memberId);
        temporarySavePost.setTitle(temporaryPostDto.getTitle());
        temporarySavePost.setContent(temporaryPostDto.getContent());
        temporarySavePost.setTemporaryStatus(temporaryPostDto.getTemporaryStatus());

        int result;
        if (temporaryPostDto.getPostId() != null) {
            result = communityMapper.updatePost(temporarySavePost);
        } else {
            // 해당 임시저장 게시글 정보가 있는지 확인
            boolean isDuplicatePost = communityMapper.isDuplicatePost(temporarySavePost);
            // 중복된 내용에 게시글이 있는 경우 수정
            if (isDuplicatePost) {
                throw new IllegalStateException("이미 임시저장된 게시글입니다.");
            }

            result = communityMapper.insertPost(temporarySavePost);
        }
        if (result != 1) {
            throw new IllegalStateException("게시글 작성을 실패했습니다.");
        }

        return temporarySavePost.getPostId();
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
            throw new IllegalStateException("수정 권한이 없거나 게시글이 존재하지 않습니다.");
        }
        return postDto.getPostId();
    }
  
      /**
     * 게시글 삭제하는 메소드
     */
    @Override
    public void deletePost(Long postId, Long memberId) {
        PostDto postDto = new PostDto();
        postDto.setPostId(postId);
        postDto.setMemberId(memberId);
        int result = communityMapper.deletePost(postId, memberId);
        if (result != 1) {
            // 실패 시 로직
            throw new IllegalStateException("삭제 권한이 없거나 게시글이 존재하지 않습니다.");
        }
    }

    /**
     * 현재 로그인되어있는 회원의 임시저장된 게시글 목록을 조회하는 메소드
     * @param memberId
     */
    @Override
    public List<PostDto> selectTemporaryPostList(Long memberId) {
        return communityMapper.selectTemporaryPostList(memberId);
    }

    /**
     * 임시저장 게시글을 불러온 후 등록을 누르는 경우에 실제로 insert가 아닌 update하는 메소드
     * @param postDto
     * @return
     */
    @Override
    public Long insertTemporaryPost(PostDto postDto) {
        int category_id = communityMapper.selectCategoryId(postDto.getCategory());
        postDto.setCategoryId(category_id);

        int result = communityMapper.insertTemporaryPost(postDto);
        if (result != 1) {
            return 0L;
        }
        return postDto.getPostId();
    }

    /**
     * 임시저장 게시글을 삭제하는 메소드
     * @param postId
     * @param memberId
     * @return
     */
}
