<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modal.css">


</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="withdraw-main">
    <div class="withdraw-inner">

        <div class="withdraw-card">

            <!-- ── 경고 헤더 ── -->
            <div class="withdraw-warning-header">
                <div class="warning-icon-wrap">
                    <svg width="36" height="36" viewBox="0 0 36 36" fill="none" aria-hidden="true">
                        <path d="M18 3L33 30H3L18 3z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <line x1="18" y1="14" x2="18" y2="22" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        <circle cx="18" cy="26" r="1.5" fill="currentColor"/>
                    </svg>
                </div>
                <h1 class="withdraw-title">정말 탈퇴하시겠습니까?</h1>
                <p class="withdraw-subtitle">탈퇴하시기 전에 아래 안내 사항을 반드시 확인해 주세요.</p>
            </div>

            <div class="mypage-divider"></div>

            <!-- ── 삭제 항목 리스트 ── -->
            <div class="withdraw-items-section">
                <h2 class="withdraw-items-title">탈퇴 시 삭제되는 항목 리스트</h2>
                <div class="withdraw-items-list">
                    <div class="withdraw-item">
                        <span class="withdraw-bullet"></span>
                        <div class="withdraw-item-text">
                            <p class="withdraw-item-name">작성한 게시글 및 댓글</p>
                            <p class="withdraw-item-desc">커뮤니티에 작성하신 모든 질문과 답변, 댓글 정보가 영구적으로 파기됩니다.</p>
                        </div>
                    </div>
                    <div class="withdraw-item">
                        <span class="withdraw-bullet"></span>
                        <div class="withdraw-item-text">
                            <p class="withdraw-item-name">개인 학습 기록</p>
                            <p class="withdraw-item-desc">Java 오늘의 미션 달성도, 연속 학습 일수(잔디), 누적 정답률 데이터가 리셋됩니다.</p>
                        </div>
                    </div>
                    <div class="withdraw-item">
                        <span class="withdraw-bullet"></span>
                        <div class="withdraw-item-text">
                            <p class="withdraw-item-name">보유 포인트 및 배지</p>
                            <p class="withdraw-item-desc">출석과 정답 보상으로 모은 가상 포인트와 배지가 전부 삭제됩니다.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ── 복구 불가 경고 ── -->
            <div class="withdraw-irreversible">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" aria-hidden="true">
                    <circle cx="10" cy="10" r="8" stroke="currentColor" stroke-width="2"/>
                    <line x1="10" y1="6" x2="10" y2="11" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                    <circle cx="10" cy="14" r="1" fill="currentColor"/>
                </svg>
                <p class="withdraw-irreversible-text">탈퇴 완료 후에는 계정을 다시 복구하거나 데이터를 되돌릴 수 없습니다.</p>
            </div>

            <c:if test="${not empty errorMsg}">
                <p class="edit-error">${errorMsg}</p>
            </c:if>
            <jsp:include page="/WEB-INF/views/common/modal/inputModal.jsp" />


            <!-- ── 액션 버튼 ── -->
            <div class="withdraw-actions">
                <button type="button"
                        id="withdraw-button"
                        class="withdraw-btn-confirm">
                    탈퇴하기
                </button>
                <a href="${pageContext.request.contextPath}/member/mypage" class="withdraw-btn-return">돌아가기</a>
            </div>

        </div>
    </div>
</main>

<form id="withdraw-form"
      action="${pageContext.request.contextPath}/member/withdraw"
      method="post">
    <input type="hidden" name="password">
</form>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
<script src="${pageContext.request.contextPath}/js/mypage-withdraw.js"></script>

</body>
</html>
