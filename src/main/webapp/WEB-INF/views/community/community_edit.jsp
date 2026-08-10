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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modal.css">
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

            <!-- ── 글 수정 폼 ── -->
            <div style="flex:1;min-width:0;">
                <form action="${pageContext.request.contextPath}/community/${postDetail.postId}/edit" method="post" id="editForm">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                    <div class="comm-form-card">

                        <!-- 브레드크럼 -->
                        <div class="comm-form-breadcrumb">
                            <span style="color:#9CA3AF;text-decoration:none;">커뮤니티</span>
                            <span>&gt;</span>
                            <span style="color:#9CA3AF;text-decoration:none;">
                                <c:choose>
                                    <c:when test="${postDetail.category == 'qna'}">질문 &amp; 답변</c:when>
                                    <c:when test="${postDetail.category == 'solution'}">풀이 공유</c:when>
                                    <c:otherwise>문제 제작</c:otherwise>
                                </c:choose>
                            </span>
                            <span>&gt;</span>
                            <span style="color:#9CA3AF;text-decoration:none;">상세</span>
                            <span>&gt;</span>
                            <span class="current">글수정</span>
                        </div>

                        <h2 class="comm-form-title">글수정</h2>

                        <div class="comm-form-divider"></div>

                        <!-- 카테고리 -->
                        <div class="comm-form-row">
                            <label class="comm-form-label" for="postType">카테고리</label>
                            <div class="comm-form-select">
                                <select id="postType" name="category" required>
                                    <option value="qna" ${postDetail.category == 'qna'      ? 'selected' : ''}>질문 &amp; 답변</option>
                                    <option value="solution" ${postDetail.category == 'solution' ? 'selected' : ''}>풀이 공유</option>
                                    <option value="problem" ${postDetail.category == 'problem'  ? 'selected' : ''}>문제 제작</option>
                                </select>
                            </div>
                        </div>

                        <!-- 제목 -->
                        <div class="comm-form-row">
                            <label class="comm-form-label" for="title">제목</label>
                            <input type="text" id="title" name="title" class="comm-form-input-real"
                                   value="${postDetail.title}" maxlength="85" required>
                        </div>

                        <!-- 내용 -->
                        <div class="comm-form-row top">
                            <label class="comm-form-label" for="content">내용</label>
                            <textarea id="content" name="content" class="comm-form-textarea" maxlength="10000" required>${postDetail.content}</textarea>
                        </div>

                        <div class="comm-form-divider"></div>

                        <!-- 버튼 -->
                        <div class="comm-form-btns">
                            <button type="submit" class="btn-submit">수정 완료</button>
                            <a href="${pageContext.request.contextPath}/community/detail/${postDetail.postId}" class="btn-cancel"
                               style="text-decoration:none;display:inline-flex;align-items:center;">취소</a>
                        </div>

                    </div>
                </form>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
<script>
    const ErrorMsg = "${errMsg}";
</script>
<script src="${pageContext.request.contextPath}/js/post.js"></script>
</body>
<jsp:include page="/WEB-INF/views/common/modal/alertModal.jsp"/>
</html>
