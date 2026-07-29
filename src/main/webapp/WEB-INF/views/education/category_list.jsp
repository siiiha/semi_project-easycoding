<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${category.name} - 카테고리 학습 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/category.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="category-list-main">
    <div class="category-list-inner">

        <!-- ── 브레드크럼 ── -->
        <nav class="breadcrumb" aria-label="breadcrumb">
            <a href="${pageContext.request.contextPath}/" class="breadcrumb-item">HOME</a>
            <span class="breadcrumb-sep">›</span>
            <a href="${pageContext.request.contextPath}/learn/category" class="breadcrumb-item">카테고리학습</a>
            <span class="breadcrumb-sep">›</span>
            <span class="breadcrumb-item active">${category.name}</span>
        </nav>

        <!-- ── 타이틀 섹션 ── -->
        <div>
            <h1 class="category-list-title">${category.name}</h1>
            <p class="category-list-desc">${category.description}</p>
        </div>

        <!-- ── 진행률 카드 ── -->
        <div class="progress-card">

            <!-- 링 차트 + 통계 -->
            <div class="progress-left">
                <div class="progress-ring-wrap">
                    <div class="progress-ring-bg"></div>
                    <div class="progress-ring-fill" style="--pct: ${progress.rate}%;"></div>
                    <div class="progress-ring-center">
                        <span class="progress-ring-pct">${progress.rate}%</span>
                        <span class="progress-ring-label">진행률</span>
                    </div>
                </div>

                <div class="progress-divider"></div>

                <div class="progress-stats">
                    <div>
                        <p class="progress-stat-label">총 문제</p>
                        <p class="progress-stat-value">${progress.total} 문제</p>
                    </div>
                    <div>
                        <p class="progress-stat-label">완료 문제</p>
                        <p class="progress-stat-value green">${progress.done} 문제</p>
                    </div>
                    <div>
                        <p class="progress-stat-label">남은 문제</p>
                        <p class="progress-stat-value">${progress.remaining} 문제</p>
                    </div>
                </div>
            </div>

            <!-- 최근 학습 + 학습 팁 -->
            <div class="progress-right">
                <div class="mini-card gray">
                    <p class="mini-card-label">최근 학습 기록</p>
                    <div style="display:flex; justify-content:space-between; align-items:center;">
                        <span class="mini-card-title">${progress.recentTitle}</span>
                        <span class="mini-card-meta">${progress.recentDate}</span>
                    </div>
                </div>
                <div class="mini-card green">
                    <p class="mini-card-label">학습 팁</p>
                    <p class="mini-card-tip">${category.tip}</p>
                </div>
            </div>

        </div>

        <!-- ── 필터 바 ── -->
        <div class="filter-bar">
            <div class="filter-selects">
                <div class="filter-select">
                    <span class="filter-select-label">문제 유형</span>
                    <select class="filter-select-value" name="type" onchange="this.form.submit()">
                        <option value="">전체</option>
                        <option value="mcq">객관식</option>
                        <option value="fill">빈칸 맞추기</option>
                    </select>
                </div>
                <div class="filter-select">
                    <span class="filter-select-label">풀이 상태</span>
                    <select class="filter-select-value" name="status" onchange="this.form.submit()">
                        <option value="">전체</option>
                        <option value="solved">완료</option>
                        <option value="wrong">오답</option>
                        <option value="unsolved">미풀이</option>
                    </select>
                </div>
            </div>
            <div class="sort-dropdown">
                <span>최신순</span>
                <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                    <path d="M3.5 5.25L7 8.75L10.5 5.25" stroke="#767676" stroke-linecap="round" stroke-width="2"/>
                </svg>
            </div>
        </div>

        <!-- ── 문제 목록 ── -->
        <div class="problem-list">
            <c:forEach var="problem" items="${problems}" varStatus="st">
                <a href="${pageContext.request.contextPath}/learn/category/${category.slug}/problem/${problem.id}"
                   class="problem-row">
                    <div class="problem-row-left">
                        <!-- 상태 인디케이터 -->
                        <c:choose>
                            <c:when test="${problem.status == 'solved'}">
                                <div class="status-dot solved">
                                    <svg width="10" height="10" viewBox="0 0 14 14" fill="none">
                                        <path d="M2.5 7L5.5 10L11.5 4" stroke="white" stroke-width="2" stroke-linecap="round"/>
                                    </svg>
                                </div>
                            </c:when>
                            <c:when test="${problem.status == 'wrong'}">
                                <div class="status-dot wrong">
                                    <svg width="10" height="10" viewBox="0 0 14 14" fill="none">
                                        <path d="M3 3L11 11M11 3L3 11" stroke="#C62828" stroke-width="2" stroke-linecap="round"/>
                                    </svg>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="status-dot unsolved"></div>
                            </c:otherwise>
                        </c:choose>

                        <div class="problem-row-text">
                            <p class="problem-row-num">문제 ${st.count}</p>
                            <p class="problem-row-title">${problem.title}</p>
                            <div class="problem-row-badges">
                                <c:choose>
                                    <c:when test="${problem.type == 'mcq'}">
                                        <span class="type-badge mcq">객관식</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="type-badge fill">빈칸 맞추기</span>
                                    </c:otherwise>
                                </c:choose>
                                <span class="problem-row-sub">${problem.description}</span>
                            </div>
                        </div>
                    </div>

                    <div class="problem-row-right">
                        <c:choose>
                            <c:when test="${problem.status == 'solved' or problem.status == 'wrong'}">
                                <span class="problem-action-btn">다시 풀기</span>
                            </c:when>
                            <c:otherwise>
                                <span class="problem-action-btn">학습하기</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </a>
            </c:forEach>
        </div>

        <!-- ── 페이지네이션 ── -->
        <div class="pagination">
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}" class="page-btn">이전</a>
                </c:when>
                <c:otherwise>
                    <span class="page-btn disabled">이전</span>
                </c:otherwise>
            </c:choose>

            <c:forEach begin="1" end="${totalPages}" var="p">
                <a href="?page=${p}" class="page-btn ${p == currentPage ? 'active' : ''}">${p}</a>
            </c:forEach>

            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}" class="page-btn">다음</a>
                </c:when>
                <c:otherwise>
                    <span class="page-btn disabled">다음</span>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
