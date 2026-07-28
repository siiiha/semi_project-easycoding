<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 글 목록 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="comm-main">
    <div class="comm-inner">

        <div class="comm-title-block">
            <h1 class="comm-title">커뮤니티</h1>
            <p class="comm-subtitle">함께 나누고, 함께 성장해요!</p>
        </div>

        <div class="comm-body">

            <!-- ── 왼쪽 사이드바 ── -->
            <nav class="comm-sidebar">
                <a href="${pageContext.request.contextPath}/community?type=all"
                   class="comm-cat-btn ${empty communityType or communityType == 'all' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${empty communityType or communityType == 'all' ? '#4CAF50' : '#1E1E1E'}" stroke-width="1.8">
                        <rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/>
                        <rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>
                    </svg>
                    <span class="comm-cat-label">전체</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=qna"
                   class="comm-cat-btn ${communityType == 'qna' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${communityType == 'qna' ? '#4CAF50' : '#333'}" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 3H5a2 2 0 0 0-2 2v4m6-6h10a2 2 0 0 1 2 2v4M9 3v11m0 0H5a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V16m-7-2h2"/>
                    </svg>
                    <span class="comm-cat-label">질문 &amp; 답변</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=solution"
                   class="comm-cat-btn ${communityType == 'solution' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${communityType == 'solution' ? '#4CAF50' : '#333'}" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M8 16L4 12L8 8"/><path d="M16 8L20 12L16 16"/><path d="M14 4L10 20"/>
                    </svg>
                    <span class="comm-cat-label">풀이 공유</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=problem"
                   class="comm-cat-btn ${communityType == 'problem' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${communityType == 'problem' ? '#4CAF50' : '#333'}" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 3L20 7L12 15H8V11L16 3Z"/><path d="M3 21h18"/>
                    </svg>
                    <span class="comm-cat-label">문제 제작</span>
                </a>
            </nav>

            <div class="comm-divider"></div>

            <!-- ── 메인: 글 목록 테이블 ── -->
            <div class="comm-content" style="position:relative;">

                <div class="comm-section-header">
                    <h2 class="comm-section-title">
                        <c:choose>
                            <c:when test="${communityType == 'qna'}">질문 &amp; 답변</c:when>
                            <c:when test="${communityType == 'solution'}">풀이 공유</c:when>
                            <c:when test="${communityType == 'problem'}">문제 제작</c:when>
                            <c:otherwise>전체글 보기</c:otherwise>
                        </c:choose>
                    </h2>
                    <a href="${pageContext.request.contextPath}/community/write" class="btn-write">글 작성하기</a>
                </div>

                <!-- 검색 -->
                <form action="${pageContext.request.contextPath}/community/list" method="get" class="post-search-row">
                    <input type="hidden" name="type" value="${communityType}">
                    <div class="post-search-input">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/></svg>
                        <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요"
                               style="border:none;background:transparent;flex:1;font-size:14px;color:#1E1E1E;outline:none;font-family:'Noto Sans KR',sans-serif;">
                    </div>
                    <button type="submit" class="post-search-btn">검색</button>
                </form>

                <!-- 테이블 -->
                <div class="post-table">
                    <div class="post-table-head">
                        <span>번호</span>
                        <span>카테고리</span>
                        <span>제목</span>
                        <span>작성자</span>
                        <span>조회수</span>
                        <span>작성일</span>
                    </div>
                    <c:forEach var="post" items="${postList}" varStatus="st">
                        <a href="${pageContext.request.contextPath}/community/${post.postId}" class="post-table-row">
                            <span class="post-table-num">${(currentPage - 1) * pageSize + st.count}</span>
                            <span>
                                <c:choose>
                                    <c:when test="${post.category == '질문&답변'}">
                                        <span class="post-cat-badge qna">${post.category}</span>
                                    </c:when>
                                    <c:when test="${post.category == '풀이공유'}">
                                        <span class="post-cat-badge solution">${post.category}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="post-cat-badge problem">${post.category}</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            <span class="post-table-title">${post.title}</span>
                            <span>${post.nickname}</span>
                            <span>${post.views}</span>
                            <span class="post-table-date">${post.createdAtStr}</span>
                        </a>
                    </c:forEach>
                </div>

                <!-- 페이지네이션 -->
                <div class="comm-pagination">
                    <c:choose>
                        <c:when test="${currentPage > 1}">
                            <a href="?type=${communityType}&page=${currentPage - 1}&keyword=${keyword}" class="page-btn-comm">이전</a>
                        </c:when>
                        <c:otherwise>
                            <span class="page-btn-comm disabled">이전</span>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach begin="1" end="${totalPages}" var="p">
                        <a href="?type=${communityType}&page=${p}&keyword=${keyword}"
                           class="page-btn-comm ${p == currentPage ? 'active' : ''}">${p}</a>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${currentPage < totalPages}">
                            <a href="?type=${communityType}&page=${currentPage + 1}&keyword=${keyword}" class="page-btn-comm">다음</a>
                        </c:when>
                        <c:otherwise>
                            <span class="page-btn-comm disabled">다음</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- ── 오른쪽 인기 사용자: 스크롤 고정 floating ── -->
                <aside class="comm-popular" style="position:fixed;bottom:40px;right:40px;z-index:50;">
                    <div class="popular-card">
                        <p class="popular-title">🏆 실시간 인기 사용자</p>
                        <div class="popular-list">
                            <c:forEach var="user" items="${popularUsers}" varStatus="st">
                                <div class="popular-item">
                                    <span class="popular-rank ${st.index < 3 ? 'top' : 'normal'}">${st.count}</span>
                                    <span class="popular-name">${user.nickname}</span>
                                    <span class="popular-point">${user.point}P</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </aside>

            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
