<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 수정 - 쉽코딩</title>
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

        <!-- 왼쪽 사이드바 + 글 수정 폼 -->
        <div class="comm-body">

            <!-- ── 왼쪽 사이드바 ── -->
            <nav class="comm-sidebar">
                <a href="${pageContext.request.contextPath}/community?type=all" class="comm-cat-btn">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="#1E1E1E" stroke-width="1.8">
                        <rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/>
                        <rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>
                    </svg>
                    <span class="comm-cat-label">전체</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=qna"
                   class="comm-cat-btn ${post.type == 'qna' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${post.type == 'qna' ? '#4CAF50' : '#333'}" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 3H5a2 2 0 0 0-2 2v4m6-6h10a2 2 0 0 1 2 2v4M9 3v11m0 0H5a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V16m-7-2h2"/>
                    </svg>
                    <span class="comm-cat-label">질문 &amp; 답변</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=solution"
                   class="comm-cat-btn ${post.type == 'solution' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${post.type == 'solution' ? '#4CAF50' : '#333'}" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M8 16L4 12L8 8"/><path d="M16 8L20 12L16 16"/><path d="M14 4L10 20"/>
                    </svg>
                    <span class="comm-cat-label">풀이 공유</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=problem"
                   class="comm-cat-btn ${post.type == 'problem' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${post.type == 'problem' ? '#4CAF50' : '#333'}" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 3L20 7L12 15H8V11L16 3Z"/><path d="M3 21h18"/>
                    </svg>
                    <span class="comm-cat-label">문제 제작</span>
                </a>
            </nav>

            <div class="comm-divider"></div>

            <!-- ── 글 수정 폼 ── -->
            <div style="flex:1;min-width:0;">
                <form action="${pageContext.request.contextPath}/community/${post.id}/edit" method="post" id="editForm">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                    <div class="comm-form-card">

                        <!-- 브레드크럼 -->
                        <div class="comm-form-breadcrumb">
                            <a href="${pageContext.request.contextPath}/community" style="color:#9CA3AF;text-decoration:none;">커뮤니티</a>
                            <span>&gt;</span>
                            <a href="${pageContext.request.contextPath}/community/list?type=${post.type}" style="color:#9CA3AF;text-decoration:none;">
                                <c:choose>
                                    <c:when test="${post.type == 'qna'}">질문 &amp; 답변</c:when>
                                    <c:when test="${post.type == 'solution'}">풀이 공유</c:when>
                                    <c:otherwise>문제 제작</c:otherwise>
                                </c:choose>
                            </a>
                            <span>&gt;</span>
                            <a href="${pageContext.request.contextPath}/community/${post.id}" style="color:#9CA3AF;text-decoration:none;">상세</a>
                            <span>&gt;</span>
                            <span class="current">글수정</span>
                        </div>

                        <h2 class="comm-form-title">글수정</h2>

                        <div class="comm-form-divider"></div>

                        <!-- 카테고리 -->
                        <div class="comm-form-row">
                            <label class="comm-form-label" for="postType">카테고리</label>
                            <div class="comm-form-select">
                                <select id="postType" name="type" required>
                                    <option value="qna"      ${post.type == 'qna'      ? 'selected' : ''}>질문 &amp; 답변</option>
                                    <option value="solution" ${post.type == 'solution' ? 'selected' : ''}>풀이 공유</option>
                                    <option value="problem"  ${post.type == 'problem'  ? 'selected' : ''}>문제 제작</option>
                                </select>
                            </div>
                        </div>

                        <!-- 제목 -->
                        <div class="comm-form-row">
                            <label class="comm-form-label" for="title">제목</label>
                            <input type="text" id="title" name="title" class="comm-form-input-real"
                                   value="${post.title}" maxlength="200" required>
                        </div>

                        <!-- 내용 -->
                        <div class="comm-form-row top">
                            <label class="comm-form-label" for="content">내용</label>
                            <textarea id="content" name="content" class="comm-form-textarea" required>${post.content}</textarea>
                        </div>

                        <div class="comm-form-divider"></div>

                        <!-- 버튼 -->
                        <div class="comm-form-btns">
                            <button type="submit" class="btn-submit">수정 완료</button>
                            <a href="${pageContext.request.contextPath}/community/${post.id}" class="btn-cancel"
                               style="text-decoration:none;display:inline-flex;align-items:center;">취소</a>
                        </div>

                    </div>
                </form>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
