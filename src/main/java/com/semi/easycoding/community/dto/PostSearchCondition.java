package com.semi.easycoding.community.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PostSearchCondition {
    private int page = 1;       // 현재 페이지
    private int pageSize = 10;  // 한 페이지의 보여주려는 게시글 갯수
    private int offset;         // DB에서 사용할 조회하려는 시작 위치
    private int limit;          // 한번에 조회하려는 갯수

<<<<<<< Updated upstream
=======
    // 검색 파라미터 - 필터 : 질문&답변, 풀이공유, 문제제작
    private String postCategory;

    private String keyword; // 검색 키워드

>>>>>>> Stashed changes
    public PostSearchCondition(int page, int pageSize) {
        this.page = page;
        this.pageSize = pageSize;
    }
}
