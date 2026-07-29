<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="site-header">
    <div class="header-inner">

        <!-- 로고 -->
        <a href="${pageContext.request.contextPath}/" class="header-logo">쉽코딩</a>

        <!-- 메인 네비게이션 -->
        <nav class="header-nav">
            <ul class="nav-list">
                <li class="nav-item has-dropdown">
                    <a href="#" class="nav-link">서비스</a>
                    <ul class="dropdown">
                        <li><a href="${pageContext.request.contextPath}/service/guide">학습가이드</a></li>
                        <li><a href="${pageContext.request.contextPath}/service/intro">서비스소개</a></li>
                    </ul>
                </li>
                <li class="nav-item has-dropdown">
                    <a href="#" class="nav-link">학습하기</a>
                    <ul class="dropdown">
                        <li><a href="${pageContext.request.contextPath}/learn/daily-quiz">일일퀴즈</a></li>
                        <li><a href="${pageContext.request.contextPath}/learn/category">카테고리학습</a></li>
                    </ul>
                </li>
                <li class="nav-item has-dropdown">
                    <a href="#" class="nav-link">커뮤니티</a>
                    <ul class="dropdown">
                        <li><a href="${pageContext.request.contextPath}/community/qna">질문&amp;답변</a></li>
                        <li><a href="${pageContext.request.contextPath}/community/share">풀이공유</a></li>
                        <li><a href="${pageContext.request.contextPath}/community/create">문제제작</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/contact" class="nav-link">문의하기</a>
                </li>
            </ul>
        </nav>

        <!-- 로그인 후 유저 영역 -->
        <div class="header-user">
            <!-- 알림 버튼 -->
            <a href="${pageContext.request.contextPath}/notification" class="notif-btn" title="알림">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#5B5B5B" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
                    <path d="M13.73 21a2 2 0 0 1-3.46 0"/>
                </svg>
                <c:if test="${not empty notifCount && notifCount > 0}">
                    <span class="notif-count">${notifCount}</span>
                </c:if>
            </a>

            <!-- 프로필 -->
            <div class="user-profile has-dropdown">
                <div class="profile-avatar">
<%-- <c:choose>
     <c:when test="${not empty sessionScope.loginUser.profileImg}">
         <img src="${sessionScope.loginUser.profileImg}" alt="프로필">
     </c:when>
     <c:otherwise>
         <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#6B6B6B" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
             <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
             <circle cx="12" cy="7" r="4"/>
         </svg>
     </c:otherwise>
 </c:choose> --%>

    <svg xmlns="http://www.w3.org/2000/svg"
         width="22"
         height="22"
         viewBox="0 0 24 24"
         fill="none"
         stroke="#6B6B6B"
         stroke-width="2"
         stroke-linecap="round"
         stroke-linejoin="round">
        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
        <circle cx="12" cy="7" r="4"/>
    </svg>

    <%--  나중에 삭제할것 --%>
</div>
<ul class="dropdown dropdown-right">
 <li><a href="${pageContext.request.contextPath}/mypage">마이페이지</a></li>
 <li><a href="${pageContext.request.contextPath}/mypage/settings">설정</a></li>
 <li class="dropdown-divider"></li>
 <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
</ul>
</div>
</div>

</div>
</header>
