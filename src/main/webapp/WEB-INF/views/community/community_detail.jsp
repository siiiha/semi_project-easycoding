<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - 쉽코딩</title>
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
    <input type="hidden" name="postId" id="post-key" value="${postDetail.postId}">
    <div class="comm-inner">

        <div class="comm-title-block">
            <h1 class="comm-title">커뮤니티</h1>
            <p class="comm-subtitle">함께 나누고, 함께 성장해요!</p>
        </div>

        <div class="comm-body">

            <!-- ── 메인: 글 상세 + 댓글 ── -->
            <div class="comm-content">

                <!-- 브레드크럼 -->
                <nav style="display:flex;gap:8px;font-size:14px;color:#9CA3AF;">
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
                    <span style="color:#1E1E1E;">상세</span>
                </nav>

                <!-- 게시글 카드 -->
                <div style="background:#fff;border:1.5px solid #B8BEC5;border-radius:12px;padding:40px;display:flex;flex-direction:column;gap:20px;">

                    <!-- 제목 + 작성자 정보 -->
                    <div style="display:flex;flex-direction:column;gap:12px;">
                        <h2 style="font-size:28px;font-weight:700;color:#1E1E1E;line-height:1.4;">${postDetail.title}</h2>
                        <div style="display:flex;align-items:center;justify-content:space-between;">
                            <div style="display:flex;align-items:center;gap:8px;">
                                <div style="width:36px;height:36px;border-radius:50%;background:#F3F4F6;border:1px solid #E5E7EB;overflow:hidden;flex-shrink:0;">
<%--                                    <c:if test="${not empty postDetail.authorProfileImage}">--%>
<%--                                        <img src="${postDetail.authorProfileImage}" alt="${post.author}" style="width:100%;height:100%;object-fit:cover;">--%>
<%--                                    </c:if>--%>
                                        <%-- 삭제할지 말지 고민중입니다. --%>
                                </div>
                                <div style="display:flex;flex-direction:column;gap:2px;">
                                    <span style="font-size:15px;font-weight:600;color:#1E1E1E;">${postDetail.nickname}</span>
                                    <span style="font-size:12px;color:#9CA3AF;">${postDetail.createdAtStr}</span>
                                </div>
                            </div>
                            <span>
                                <span style="font-size:14px;font-weight:600;color:#5B5B5B;">조회수 ${postDetail.views} &nbsp;|&nbsp;</span>
                                <span id="comment-count" style="font-size:14px;font-weight:600;color:#5B5B5B;"></span>
                            </span>
                        </div>
                    </div>

                    <div style="height:1px;background:#B8BEC5;"></div>

                    <!-- 본문 -->
                    <div style="font-size:16px;color:#1E1E1E;line-height:1.7;white-space:pre-line;">${postDetail.content}</div>

                    <div style="height:1px;background:#B8BEC5;"></div>

                    <!-- 수정 / 삭제 (본인 글만 노출) -->
                    <c:if test="${postDetail.nickname == sessionScope.loginUser.nickname}">
                        <div style="display:flex;gap:12px;justify-content:flex-end;">
                            <a href="${pageContext.request.contextPath}/community/${postDetail.postId}/edit"
                               style="padding:6px 16px;background:#fff;border:1px solid #D9D9D9;border-radius:6px;font-size:13px;font-weight:600;color:#5B5B5B;text-decoration:none;">수정</a>
                            <form id="delete-post-form" action="${pageContext.request.contextPath}/community/${postDetail.postId}/delete" method="post" style="display:inline;">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <button id="delete-post-btn" type="submit"
                                        style="padding:6px 16px;background:#fff;border:1px solid #D9D9D9;border-radius:6px;font-size:13px;font-weight:600;color:#5B5B5B;cursor:pointer;">삭제</button>
                            </form>
                        </div>
                    </c:if>
                </div>

                <!-- 댓글 섹션 -->
                <div style="background:#fff;border:1.5px solid #B8BEC5;border-radius:12px;padding:40px;display:flex;flex-direction:column;gap:28px;">
                    <p style="font-size:22px;font-weight:700;color:#1E1E1E;">댓글 ${post.commentCount}</p>

                    <!-- 댓글 입력 -->
                    <form id="comment-form" action="${pageContext.request.contextPath}/comment/insert/${postDetail.postId}" method="post" style="display:flex;flex-direction:column;gap:12px;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <div>
                        <textarea name="content" rows="4"
                                  maxlength="300"
                                  placeholder="댓글을 입력해보세요... (커뮤니티 가이드를 준수하여 고운 말을 사용해주세요.)"
                                  style="width:100%;border:1.5px solid #D9D9D9;border-radius:6px;padding:12px;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1E1E1E;resize:none;outline:none;box-sizing:border-box;"
                                  onfocus="this.style.borderColor='#4CAF50'"
                                  onblur="this.style.borderColor='#D9D9D9'"
                                  oninput="checkLength(this, document.getElementById('charCount'))"></textarea>
                        <!-- 사용자에게 현재 글자 수를 보여줄 UI 공간 (선택사항) -->
                        <div style="text-align: right; font-size: 12px; color: #666; margin-right: 8px;">
                            <span id="charCount">0</span>/300자
                        </div>
                        </div>
                        <div style="display:flex;justify-content:flex-end;">
                            <button type="submit"
                                    style="padding:10px 20px;background:#4CAF50;border:none;border-radius:6px;color:#fff;font-size:14px;font-weight:700;cursor:pointer;">댓글 등록</button>
                        </div>
                    </form>

                    <div style="height:1px;background:#E6E6E6;"></div>

                    <!-- 댓글 목록 -->
                    <div id="comments-area" style="display:flex;flex-direction:column;gap:24px;">
                        <c:forEach var="comment" items="${comments}">
                            <div class="comment" style="display:flex;flex-direction:column;gap:12px;">
                                <!--게시글 하나 영역--><div style="display:flex;align-items:center;justify-content:space-between;">
                                    <!--프로필+작성자 영역-->
                                    <div style="display:flex;align-items:center;gap:10px;">
                                        <!--프로필영역-->
                                        <div style="width:32px;height:32px;border-radius:50%;background:#F3F4F6;border:1px solid #E5E7EB;overflow:hidden;flex-shrink:0;">
                                            <c:if test="${not empty comment.authorProfileImage}">
                                                <!--이미지 태그-->
                                                <img src="${comment.authorProfileImage}" alt="${comment.author}" style="width:100%;height:100%;object-fit:cover;">
                                            </c:if>
                                        </div>
                                        <!--작성자 + 작성일영역-->
                                        <div style="display:flex;flex-direction:column;gap:2px;">
                                            <!--작성자-->
                                            <span style="font-size:14px;font-weight:600;color:#1E1E1E;">${comment.author}</span>
                                            <!--작성일-->
                                            <span style="font-size:11px;color:#9CA3AF;">${comment.createdAt}</span>
                                        </div>
                                    </div>
                                    <c:if test="${comment.author == sessionScope.loginUser.nickname}">
                                        <!--댓글 내용 영역-->
                                        <div style="display:flex;gap:12px;font-size:12px;color:#9CA3AF;">
                                            <span onclick="toggleCommentEdit(${comment.id})" style="cursor:pointer;">수정</span>
                                            <form action="${pageContext.request.contextPath}/community/${post.id}/comment/${comment.id}/delete"
                                                  method="post" style="display:inline;" onsubmit="return confirm('삭제하시겠습니까?')">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                <button type="submit" style="border:none;background:none;color:#9CA3AF;font-size:12px;cursor:pointer;padding:0;">삭제</button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- 댓글 본문 / 수정 폼 -->
                                <div id="comment-text-${comment.id}">
                                    <p style="font-size:14px;font-weight:600;color:#1E1E1E;line-height:1.6;">${comment.content}</p>
                                </div>
                                <form id="comment-edit-${comment.id}"
                                      action="${pageContext.request.contextPath}/community/${post.id}/comment/${comment.id}/edit"
                                      method="post" style="display:none;flex-direction:column;gap:8px;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                    <textarea name="content" rows="4"
                                              style="width:100%;border:1.5px solid #4CAF50;border-radius:6px;padding:12px;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1E1E1E;resize:vertical;outline:none;box-sizing:border-box;">${comment.content}</textarea>
                                    <div style="display:flex;gap:8px;justify-content:flex-end;">
                                        <button type="button" onclick="toggleCommentEdit(${comment.id})"
                                                style="padding:8px 16px;background:#fff;border:1px solid #D9D9D9;border-radius:6px;font-size:13px;font-weight:600;color:#5B5B5B;cursor:pointer;">취소</button>
                                        <button type="submit"
                                                style="padding:8px 16px;background:#4CAF50;border:none;border-radius:6px;font-size:13px;font-weight:700;color:#fff;cursor:pointer;">수정</button>
                                    </div>
                                </form>

                                <div style="height:1px;background:#E6E6E6;"></div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- 목록으로 -->
                <div>
                    <a href="${pageContext.request.contextPath}${redirectURL}"
                       style="display:inline-flex;padding:10px 24px;border:1.5px solid #9CA3AF;border-radius:8px;font-size:14px;font-weight:600;color:#5B5B5B;text-decoration:none;">
                        ← 목록으로
                    </a>
                </div>

            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
    const loginNickname = "${sessionScope.loginUser.nickname}";
    const contextPath = "${pageContext.request.contextPath}";
    const postId = "${post.id}";
</script>
<script>
function toggleCommentEdit(id) {
    var textDiv = document.getElementById('comment-text-' + id);
    var formEl  = document.getElementById('comment-edit-' + id);
    var isHidden = formEl.style.display === 'none' || formEl.style.display === '';
    textDiv.style.display = isHidden ? 'none' : 'block';
    formEl.style.display  = isHidden ? 'flex' : 'none';
}
</script>
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
<script>
const ErrorMsg = "${errMsg}";
const successMsg = "${successMsg}";
</script>
<script src="${pageContext.request.contextPath}/js/post.js"></script>
<script src="${pageContext.request.contextPath}/js/comment.js"></script>
<script src="${pageContext.request.contextPath}/js/comment-reply.js"></script>
</body>
<jsp:include page="/WEB-INF/views/common/modal/alertModal.jsp"/>
<jsp:include page="/WEB-INF/views/common/modal/confirmModal.jsp"/>
</html>
