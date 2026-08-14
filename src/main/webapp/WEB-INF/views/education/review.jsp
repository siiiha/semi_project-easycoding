<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/review.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="review-page">
    <div class="review-wrap">
        <c:choose>
            <c:when test="${empty submittedList}">
                <section class="review-empty">
                    <p class="review-empty-title">이 날짜에는 푼 문제가 없어요.</p>
                    <p class="review-empty-desc">매일매일 꾸준히 퀴즈를 풀어보세요.</p>
                </section>
            </c:when>
            <c:otherwise>
                <div class="review-slider-wrap" id="review-slider-wrap">
                    <div class="review-slider-track">
                        <section class="review-panel review-list-panel" aria-label="문제 목록">
                            <c:forEach var="edu" items="${submittedList}" varStatus="status">
                                <div class="review-card ${not edu.answered ? 'is-pending' : (edu.correct ? 'is-correct' : 'is-wrong')}"
                                     data-index="${status.index}"
                                     data-answered="${edu.answered}"
                                     data-correct="${edu.correct}"
                                     data-chose-option="${edu.choseOption}"
                                     data-education-type="${edu.educationType}"
                                     tabindex="${edu.answered ? '0' : '-1'}"
                                     aria-label="문제 ${status.index + 1}"
                                     aria-disabled="${not edu.answered}">
                                        <div class="review-result-icon" aria-hidden="true">
                                            <c:choose>
                                                <c:when test="${not edu.answered}">-</c:when>
                                                <c:when test="${edu.correct}">✓</c:when>
                                                <c:otherwise>✕</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="review-content">
                                            <p class="review-order">문제 ${status.index + 1}</p>
                                            <h2 class="review-title"><c:out value="${edu.educationTitle}" /></h2>
                                            <div class="review-meta">
                                                <span class="review-type">
                                                    <c:choose>
                                                        <c:when test="${edu.educationType == 1}">객관식</c:when>
                                                        <c:when test="${edu.educationType == 2}">빈칸 맞추기</c:when>
                                                        <c:otherwise>타입 <c:out value="${edu.educationType}" /></c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <span class="review-category"><c:out value="${edu.educationCategoryName}" /></span>
                                            </div>
                                            <p class="review-description"><c:out value="${edu.educationContent}" /></p>

                                            <p class="review-data-content is-hidden"><c:out value="${edu.educationContent}" /></p>
                                            <p class="review-data-explanation is-hidden"><c:out value="${edu.educationExplanation}" /></p>
                                            <div class="review-data-options is-hidden">
                                                <c:forEach var="opt" items="${edu.options}">
                                                    <p class="review-data-option"
                                                       data-order="${opt.orderingNumber}"
                                                       data-correct="${opt.correct}">
                                                        <c:out value="${opt.optionContents}" />
                                                    </p>
                                                </c:forEach>
                                            </div>
                                        </div>
                                </div>
                            </c:forEach>
                        </section>

                        <section class="review-panel review-detail-panel" aria-label="문제 상세">
                            <button type="button" class="review-back-btn" id="review-back-btn">← 목록으로</button>

                            <article class="review-detail-card">
                                <p class="review-order" id="detail-order">문제</p>
                                <h2 class="review-title" id="detail-title">문제를 선택해주세요.</h2>
                                <div class="review-meta">
                                    <span class="review-type" id="detail-type">-</span>
                                    <span class="review-category" id="detail-category">-</span>
                                </div>

                                <p class="review-detail-question" id="detail-question">왼쪽 목록에서 문제를 선택하면 선택한 답안, 정답, 해설을 보여줍니다.</p>

                                <div class="review-answer-grid">
                                    <div class="review-answer-box is-mine">
                                        <p class="review-answer-label">내가 선택한 답안</p>
                                        <p class="review-answer-value" id="detail-my-answer">-</p>
                                    </div>
                                    <div class="review-answer-box is-correct">
                                        <p class="review-answer-label">실제 정답</p>
                                        <p class="review-answer-value" id="detail-correct-answer">-</p>
                                    </div>
                                </div>

                                <div class="review-option-list" id="detail-option-list"></div>

                                <div class="review-explanation-box">
                                    <p class="review-explanation-title">문제 해설</p>
                                    <p class="review-explanation-text" id="detail-explanation">-</p>
                                </div>
                            </article>
                        </section>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/review.js"></script>
</body>
</html>
