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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="mypage-main">
    <div class="mypage-inner">

        <h1 class="mypage-title">마이페이지</h1>

        <div class="mypage-card">

            <!-- ── 계정 관리 ── -->
            <section class="mypage-section">
                <h2 class="mypage-section-title">계정 관리</h2>

                <div class="account-layout">
                    <!-- 아바타 -->
                    <div class="avatar-section">
                        <div class="avatar-circle avatar-circle-lg">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loginUser.profileImage}">
                                    <img src="${sessionScope.loginUser.profileImage}" alt="프로필 이미지" class="avatar-img">
                                </c:when>
                                <c:otherwise>
                                    <svg width="72" height="72" viewBox="0 0 28 28" fill="none" aria-hidden="true">
                                        <path clip-rule="evenodd" d="M14 2a5 5 0 1 1 0 10A5 5 0 0 1 14 2zm0 12c6 0 10 2.7 10 4v2H4v-2c0-1.3 4-4 10-4z" fill="#4F378A" fill-rule="evenodd"/>
                                    </svg>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- 정보 행 -->
                    <div class="info-rows">
                        <div class="info-row">
                            <svg class="info-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#1E1E1E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
                            </svg>
                            <span class="info-value info-name">${sessionScope.loginUser.name}</span>
                        </div>
                        <div class="info-row">
                            <svg class="info-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#1E1E1E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/>
                            </svg>
                            <span class="info-value">${sessionScope.loginUser.email}</span>
                        </div>
                        <div class="info-row">
                            <svg class="info-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#1E1E1E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>
                            </svg>
                            <span class="info-value">${sessionScope.loginUser.joinDate}</span>
                        </div>
                        <div class="info-row">
                            <svg class="info-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#1E1E1E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                            <span class="info-value">비밀번호</span>
                            <a href="${pageContext.request.contextPath}/member/edit" class="info-modify-btn">수정</a>
                        </div>
                    </div>
                </div>
            </section>

            <div class="mypage-divider"></div>

            <!-- ── 내 활동 ── -->
            <section class="mypage-section">
                <h2 class="mypage-section-title section-title-sm">내 활동</h2>

                <div class="activity-stats">
                    <!-- 작성한 게시글 -->
                    <div class="activity-card">
                        <div class="activity-icon-wrap green">
                            <svg width="32" height="32" viewBox="0 0 50 50" fill="none" aria-hidden="true">
                                <path d="M27 13L37 23" stroke="#43A047" stroke-width="2"/>
                                <path d="M10 32l-3 8 8-3L37 15 27 5 10 32z" fill="#43A047"/>
                            </svg>
                        </div>
                        <div class="activity-info">
                            <p class="activity-label">작성한 게시글</p>
                            <p class="activity-count">${postCount != null ? postCount : 0}개</p>
                        </div>
                    </div>

                    <!-- 작성한 댓글 -->
                    <div class="activity-card">
                        <div class="activity-icon-wrap yellow">
                            <svg width="32" height="32" viewBox="0 0 50 50" fill="none" aria-hidden="true">
                                <path d="M42 10H8a2 2 0 0 0-2 2v20a2 2 0 0 0 2 2h10l7 8 7-8h10a2 2 0 0 0 2-2V12a2 2 0 0 0-2-2z" fill="#FFB700"/>
                            </svg>
                        </div>
                        <div class="activity-info">
                            <p class="activity-label">작성한 댓글</p>
                            <p class="activity-count">${commentCount != null ? commentCount : 0}개</p>
                        </div>
                    </div>

                    <!-- 탈퇴 버튼 -->
                    <div class="activity-withdraw-wrap">
                        <a href="${pageContext.request.contextPath}/member/withdraw" class="withdraw-btn">탈퇴 하기</a>
                    </div>
                </div>
            </section>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
</body>
</html>
