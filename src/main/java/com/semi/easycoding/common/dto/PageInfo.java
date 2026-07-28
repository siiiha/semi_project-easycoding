package com.semi.easycoding.common.dto;

import lombok.Getter;

@Getter
public class PageInfo {
    private int page;       // 현재 페이지
    private int pageSize;   // 한 페이지의 게시글 수
    private int totalCount; // 전체 게시글 수
    private int totalPages;  // 페이징의 갯수

    private int startPage;  // 시작 페이지 번호
    private int endPage;    // 마지막 페이지 번호

    private boolean hasPrevPage;    // 이전 페이징 그룹이 있는지 여부
    private boolean hasNextPage;    // 다음 페이징 그룹이 있는지 여부

    private static final int PAGE_GROUP_SIZE = 5;   // 하단에 표시되는 페이징 번호의 갯수

    public PageInfo(int page, int pageSize, int totalCount) {
        this.page = (page < 1) ? 1 : page;
        this.pageSize = pageSize;
        this.totalCount = totalCount;

        // totalPages = (totalCount + pageSize -1) / pageSize;
        this.totalPages = (totalCount + pageSize -1) / pageSize;

        this.startPage = ((this.page - 1) / PAGE_GROUP_SIZE) * PAGE_GROUP_SIZE + 1;
        this.endPage = Math.min(startPage + PAGE_GROUP_SIZE - 1, this.totalPages);

        this.hasPrevPage = startPage > 1;
        this.hasNextPage = endPage < this.totalPages;

    }

    public int getOffset() { return (page - 1) * pageSize; }
    public int getLimit() { return pageSize; }
}
