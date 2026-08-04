<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="mypage-main">
    <div class="mypage-inner">
        <h1 class="mypage-title">마이페이지</h1>

        <div class="mypage-card">
            <section class="mypage-section">
                <h2 class="mypage-section-title">계정 관리</h2>

                <div class="account-layout">
                    <div class="avatar-section">
                        <div class="avatar-circle">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loginUser.profileImg}">
                                    <img src="${sessionScope.loginUser.profileImg}"
                                         alt="프로필 이미지" class="avatar-img">
                                </c:when>
                                <c:otherwise>
                                    <svg width="100" height="100" viewBox="0 0 28 28"
                                         fill="none" aria-hidden="true">
                                        <path clip-rule="evenodd"
                                              d="M14 2a5 5 0 1 1 0 10A5 5 0 0 1 14 2zm0 12c6 0 10 2.7 10 4v2H4v-2c0-1.3 4-4 10-4z"
                                              fill="currentColor" fill-rule="evenodd"/>
                                    </svg>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="info-rows">
                        <div class="info-row">
                            <svg class="info-icon" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                <circle cx="12" cy="7" r="4"/>
                            </svg>
                            <span class="info-value info-name">${sessionScope.loginUser.nickname}</span>
                        </div>
                        <div class="info-row">
                            <svg class="info-icon" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="5" width="18" height="14" rx="2"/>
                                <path d="m3 7 9 6 9-6"/>
                            </svg>
                            <span class="info-value">${sessionScope.loginUser.email}</span>
                        </div>
                        <div class="info-row">
                            <svg class="info-icon" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="4" width="18" height="18" rx="2"/>
                                <path d="M16 2v4M8 2v4M3 10h18"/>
                            </svg>
                            <span class="info-value">가입날짜 ${sessionScope.loginUser.createdAt}</span>
                            <a href="${pageContext.request.contextPath}/member/edit"
                               class="info-modify-btn">회원수정</a>
                        </div>
                    </div>
                </div>
            </section>

            <div class="mypage-divider"></div>

            <section class="mypage-section">
                <h2 class="mypage-section-title section-title-sm">내 활동</h2>
                <div class="activity-stats">
                    <div class="activity-card">
                        <div class="activity-icon-wrap green">
                            <svg width="52" height="52" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <path d="M12 20h9"/>
                                <path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L8 18l-4 1 1-4Z"/>
                            </svg>
                        </div>
                        <div class="activity-info">
                            <span class="activity-label">작성한 게시글</span>
                            <span class="activity-count">${empty postCount ? 0 : postCount}개</span>
                        </div>
                    </div>

                    <div class="activity-card">
                        <div class="activity-icon-wrap yellow">
                            <svg width="52" height="52" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <path d="M21 15a4 4 0 0 1-4 4H8l-5 3V7a4 4 0 0 1 4-4h10a4 4 0 0 1 4 4Z"/>
                                <path d="M8 10h.01M12 10h.01M16 10h.01"/>
                            </svg>
                        </div>
                        <div class="activity-info">
                            <span class="activity-label">작성한 댓글</span>
                            <span class="activity-count">${empty commentCount ? 0 : commentCount}개</span>
                        </div>
                    </div>

                    <div class="activity-withdraw-wrap">
                        <a href="${pageContext.request.contextPath}/member/withdraw"
                           class="withdraw-btn">탈퇴 하기</a>
                    </div>
                </div>
            </section>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
