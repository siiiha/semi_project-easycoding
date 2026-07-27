<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        <!-- 로그인 영역 -->
        <div class="header-auth">
            <span class="auth-text">이미 계정이 있으신가요?</span>
            <a href="${pageContext.request.contextPath}/member/login" class="auth-login-btn">로그인</a>
        </div>

    </div>
</header>
