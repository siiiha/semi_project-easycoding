<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 - 쉽코딩</title>
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

        <!-- 타이틀 -->
        <div class="comm-title-block">
            <h1 class="comm-title">커뮤니티</h1>
            <p class="comm-subtitle">함께 나누고, 함께 성장해요!</p>
        </div>

        <div class="comm-body">

            <!-- ── 왼쪽 카테고리 사이드바 ── -->
            <nav class="comm-sidebar">
                <a href="${pageContext.request.contextPath}/community?type=all"
                   class="comm-cat-btn ${empty param.type or param.type == 'all' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${empty param.type or param.type == 'all' ? '#4CAF50' : '#1E1E1E'}" stroke-width="1.8">
                        <rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/>
                        <rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>
                    </svg>
                    <span class="comm-cat-label">전체</span>
                </a>
                <a href="${pageContext.request.contextPath}/community?type=qna"
                   class="comm-cat-btn ${param.type == 'qna' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${param.type == 'qna' ? '#4CAF50' : '#333'}" stroke-width="1.6">
                        <path d="M9 3H5a2 2 0 0 0-2 2v4m6-6h10a2 2 0 0 1 2 2v4M9 3v11m0 0H5a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V16m-7-2h2"/>
                    </svg>
                    <span class="comm-cat-label">질문 &amp; 답변</span>
                </a>
                <a href="${pageContext.request.contextPath}/community?type=solution"
                   class="comm-cat-btn ${param.type == 'solution' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${param.type == 'solution' ? '#4CAF50' : '#333'}" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M8 16L4 12L8 8"/><path d="M16 8L20 12L16 16"/><path d="M14 4L10 20"/>
                    </svg>
                    <span class="comm-cat-label">풀이 공유</span>
                </a>
                <a href="${pageContext.request.contextPath}/community?type=problem"
                   class="comm-cat-btn ${param.type == 'problem' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${param.type == 'problem' ? '#4CAF50' : '#333'}" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 3L20 7L12 15H8V11L16 3Z"/>
                        <path d="M3 21h18" stroke-linecap="round"/>
                    </svg>
                    <span class="comm-cat-label">문제 제작</span>
                </a>
            </nav>

            <!-- 구분선 -->
            <div class="comm-divider"></div>

            <!-- ── 메인 콘텐츠: 최근글 ── -->
            <div class="comm-content">

                <div class="comm-section-header">
                    <h2 class="comm-section-title">최근글</h2>
                    <a href="${pageContext.request.contextPath}/community/write" class="btn-write">글 작성하기</a>
                </div>

                <div class="post-card-list">
                    <c:forEach var="post" items="${recentPosts}">
                        <a href="${pageContext.request.contextPath}/community/${post.id}" class="post-card">
                            <div>
                                <c:choose>
                                    <c:when test="${post.type == 'qna'}">
                                        <span class="post-cat-badge qna">질문 &amp; 답변</span>
                                    </c:when>
                                    <c:when test="${post.type == 'solution'}">
                                        <span class="post-cat-badge solution">풀이 공유</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="post-cat-badge problem">문제 제작</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <p class="post-card-title">${post.title}</p>
                            <div class="post-card-meta">
                                <span class="author">${post.author}</span>
                                <span>${post.timeAgo}</span>
                                <span>조회 ${post.views}</span>
                                <span>추천 ${post.likes}</span>
                                <span>댓글 ${post.commentCount}</span>
                            </div>
                        </a>
                    </c:forEach>
                </div>

            </div>

            <!-- ── 오른쪽: 실시간 인기 사용자 (스크롤 고정) ── -->
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
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
