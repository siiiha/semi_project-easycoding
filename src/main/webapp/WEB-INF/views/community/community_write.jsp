<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 작성 - 쉽코딩</title>
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

        <!-- 글 작성 카드 (사이드바 없음) -->
        <form action="${pageContext.request.contextPath}/community/write" method="post" id="writeForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

            <div class="comm-form-card">

                <!-- 브레드크럼 -->
                <div class="comm-form-breadcrumb">
                    <span style="color:#9CA3AF;text-decoration:none;">커뮤니티</span>
                    <span>&gt;</span>
                    <span class="current">글작성</span>
                </div>

                <h2 class="comm-form-title">글작성</h2>

                <div class="comm-form-divider"></div>

                <!-- 카테고리 -->
                <div class="comm-form-row">
                    <label class="comm-form-label" for="postType">카테고리</label>
                    <div class="comm-form-select">
                        <select id="postType" name="category" required>
                            <option value="" disabled selected>카테고리를 선택해주세요</option>
                            <option value="qna">질문 &amp; 답변</option>
                            <option value="solution">풀이 공유</option>
                            <option value="problem">문제 제작</option>
                        </select>
                    </div>
                </div>

                <!-- 제목 -->
                <div class="comm-form-row">
                    <label class="comm-form-label" for="title">제목</label>
                    <input type="text" id="title" name="title" class="comm-form-input-real"
                           placeholder="제목을 입력해주세요" maxlength="85" required value="<c:out value="${param.title}"/>">
                </div>

                <!-- 내용 -->
                <div class="comm-form-row top">
                    <label class="comm-form-label" for="content">내용</label>
                    <textarea id="content" name="content" class="comm-form-textarea"
                              placeholder="내용을 입력해주세요" maxlength="10000" required><c:out value="${param.content}"/></textarea>
                </div>

                <div class="comm-form-divider"></div>

                <!-- 버튼 -->
                <div class="comm-form-btns">
                    <button type="button" class="btn-temp-save" onclick="saveDraft()">임시저장</button>
                    <div style="flex:1;"></div>
                    <button type="submit" class="btn-submit">등록</button>
                    <a href="${pageContext.request.contextPath}/community" class="btn-cancel"
                       style="text-decoration:none;display:inline-flex;align-items:center;">취소</a>
                </div>

            </div>
        </form>

    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
function saveDraft() {
    var form = document.getElementById('writeForm');
    var action = form.action;
    form.action = action + '?draft=true';
    form.submit();
    form.action = action;
}
</script>
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
<script>
    const editErrorMsg = "${errMsg}";
</script>
<script src="${pageContext.request.contextPath}/js/post.js"></script>
</body>
<jsp:include page="/WEB-INF/views/common/modal/alertModal.jsp"/>
</html>
