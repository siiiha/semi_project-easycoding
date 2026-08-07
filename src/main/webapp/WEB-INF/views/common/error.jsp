<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쉽코딩 - 페이지를 찾을 수 없어요</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modal.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- Spring Boot 3(jakarta)와 기존 Servlet(javax) 오류 속성을 모두 지원합니다. --%>
<c:set var="errorStatus" value="${requestScope['jakarta.servlet.error.status_code']}" />
<c:if test="${empty errorStatus}">
    <c:set var="errorStatus" value="${requestScope['javax.servlet.error.status_code']}" />
</c:if>

<main class="error-page">
    <section class="card error-card" aria-labelledby="error-title">
        <div class="error-copy">
            <span class="error-badge">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" aria-hidden="true">
                    <circle cx="12" cy="12" r="9"></circle>
                    <path d="m9 9 6 6m0-6-6 6"></path>
                </svg>
                잘못된 접근
            </span>
            <div class="error-code"><c:out value="${empty errorStatus ? '404' : errorStatus}" /></div>
            <c:choose>
                <c:when test="${errorStatus == 403}">
                    <h1 class="error-title" id="error-title">이 페이지에 접근할 권한이 없어요.</h1>
                    <p class="error-description">로그인 상태나 접근 권한을 확인한 뒤 다시 시도해 주세요.</p>
                </c:when>
                <c:when test="${errorStatus == 500}">
                    <h1 class="error-title" id="error-title">서비스 처리 중 문제가 발생했어요.</h1>
                    <p class="error-description">잠시 후 다시 시도해 주세요. 문제가 계속되면 문의하기를 이용해 주세요.</p>
                </c:when>
                <c:otherwise>
                    <h1 class="error-title" id="error-title">요청하신 페이지를 찾을 수 없어요.</h1>
                    <p class="error-description">
                        주소가 변경되었거나 존재하지 않는 페이지예요.<br>
                        잠시 후 다시 시도하거나 메인 페이지로 이동해 주세요.
                    </p>
                </c:otherwise>
            </c:choose>
            <div class="error-actions">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/">메인으로 가기</a>
                <button class="btn btn-outline" type="button" onclick="history.back()">이전 페이지</button>
            </div>
        </div>
        <div class="error-illustration">
            <img src="${pageContext.request.contextPath}/images/인사하는_양.png" alt="안내하는 양 캐릭터">
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
<script>
    const editErrorMsg = "${errMsg}";
</script>
<script src="${pageContext.request.contextPath}/js/errorPage.js"></script>
</body>
<jsp:include page="/WEB-INF/views/common/modal/alertModal.jsp"/>
</html>
