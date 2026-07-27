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

        <div class="comm-body">

            <!-- ── 왼쪽 사이드바 ── -->
            <nav class="comm-sidebar">
                <a href="${pageContext.request.contextPath}/community?type=all" class="comm-cat-btn">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="#1E1E1E" stroke-width="1.8">
                        <rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/>
                        <rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>
                    </svg>
                    <span class="comm-cat-label">전체</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=qna"
                   class="comm-cat-btn ${post.type == 'qna' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${post.type == 'qna' ? '#4CAF50' : '#333'}" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 3H5a2 2 0 0 0-2 2v4m6-6h10a2 2 0 0 1 2 2v4M9 3v11m0 0H5a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V16m-7-2h2"/>
                    </svg>
                    <span class="comm-cat-label">질문 &amp; 답변</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=solution"
                   class="comm-cat-btn ${post.type == 'solution' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${post.type == 'solution' ? '#4CAF50' : '#333'}" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M8 16L4 12L8 8"/><path d="M16 8L20 12L16 16"/><path d="M14 4L10 20"/>
                    </svg>
                    <span class="comm-cat-label">풀이 공유</span>
                </a>
                <a href="${pageContext.request.contextPath}/community/list?type=problem"
                   class="comm-cat-btn ${post.type == 'problem' ? 'active' : ''}">
                    <svg class="comm-cat-icon" viewBox="0 0 24 24" fill="none" stroke="${post.type == 'problem' ? '#4CAF50' : '#333'}" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 3L20 7L12 15H8V11L16 3Z"/><path d="M3 21h18"/>
                    </svg>
                    <span class="comm-cat-label">문제 제작</span>
                </a>
            </nav>

            <div class="comm-divider"></div>

            <!-- ── 메인: 글 상세 + 댓글 ── -->
            <div class="comm-content">

                <!-- 브레드크럼 -->
                <nav style="display:flex;gap:8px;font-size:14px;color:#9CA3AF;">
                    <a href="${pageContext.request.contextPath}/community" style="color:#9CA3AF;text-decoration:none;">커뮤니티</a>
                    <span>&gt;</span>
                    <a href="${pageContext.request.contextPath}/community/list?type=${post.type}" style="color:#9CA3AF;text-decoration:none;">
                        <c:choose>
                            <c:when test="${post.type == 'qna'}">질문 &amp; 답변</c:when>
                            <c:when test="${post.type == 'solution'}">풀이 공유</c:when>
                            <c:otherwise>문제 제작</c:otherwise>
                        </c:choose>
                    </a>
                    <span>&gt;</span>
                    <span style="color:#1E1E1E;">상세</span>
                </nav>

                <!-- 게시글 카드 -->
                <div style="background:#fff;border:1.5px solid #B8BEC5;border-radius:12px;padding:40px;display:flex;flex-direction:column;gap:20px;">

                    <!-- 제목 + 작성자 정보 -->
                    <div style="display:flex;flex-direction:column;gap:12px;">
                        <h2 style="font-size:28px;font-weight:700;color:#1E1E1E;line-height:1.4;">${post.title}</h2>
                        <div style="display:flex;align-items:center;justify-content:space-between;">
                            <div style="display:flex;align-items:center;gap:8px;">
                                <div style="width:36px;height:36px;border-radius:50%;background:#F3F4F6;border:1px solid #E5E7EB;overflow:hidden;flex-shrink:0;">
                                    <c:if test="${not empty post.authorProfileImage}">
                                        <img src="${post.authorProfileImage}" alt="${post.author}" style="width:100%;height:100%;object-fit:cover;">
                                    </c:if>
                                </div>
                                <div style="display:flex;flex-direction:column;gap:2px;">
                                    <span style="font-size:15px;font-weight:600;color:#1E1E1E;">${post.author}</span>
                                    <span style="font-size:12px;color:#9CA3AF;">${post.createdAt}</span>
                                </div>
                            </div>
                            <span style="font-size:14px;font-weight:600;color:#5B5B5B;">조회 ${post.views} &nbsp;|&nbsp; 추천 ${post.likes} &nbsp;|&nbsp; 댓글 ${post.commentCount}</span>
                        </div>
                    </div>

                    <div style="height:1px;background:#B8BEC5;"></div>

                    <!-- 본문 -->
                    <div style="font-size:16px;color:#1E1E1E;line-height:1.7;white-space:pre-line;">${post.content}</div>

                    <div style="height:1px;background:#B8BEC5;"></div>

                    <!-- 수정 / 삭제 (본인 글만 노출) -->
                    <c:if test="${post.author == sessionScope.loginUser.nickname}">
                        <div style="display:flex;gap:12px;justify-content:flex-end;">
                            <a href="${pageContext.request.contextPath}/community/${post.id}/edit"
                               style="padding:6px 16px;background:#fff;border:1px solid #D9D9D9;border-radius:6px;font-size:13px;font-weight:600;color:#5B5B5B;text-decoration:none;">수정</a>
                            <form action="${pageContext.request.contextPath}/community/${post.id}/delete" method="post" style="display:inline;"
                                  onsubmit="return confirm('정말 삭제하시겠습니까?')">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <button type="submit"
                                        style="padding:6px 16px;background:#fff;border:1px solid #D9D9D9;border-radius:6px;font-size:13px;font-weight:600;color:#5B5B5B;cursor:pointer;">삭제</button>
                            </form>
                        </div>
                    </c:if>
                </div>

                <!-- 댓글 섹션 -->
                <div style="background:#fff;border:1.5px solid #B8BEC5;border-radius:12px;padding:40px;display:flex;flex-direction:column;gap:28px;">
                    <p style="font-size:22px;font-weight:700;color:#1E1E1E;">댓글 ${post.commentCount}</p>

                    <!-- 댓글 입력 -->
                    <form action="${pageContext.request.contextPath}/community/${post.id}/comment" method="post" style="display:flex;flex-direction:column;gap:12px;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <textarea name="content" rows="4"
                                  placeholder="답글을 입력해보세요... (커뮤니티 가이드를 준수하여 고운 말을 사용해주세요.)"
                                  style="width:100%;border:1.5px solid #D9D9D9;border-radius:6px;padding:12px;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1E1E1E;resize:vertical;outline:none;box-sizing:border-box;"
                                  onfocus="this.style.borderColor='#4CAF50'" onblur="this.style.borderColor='#D9D9D9'"></textarea>
                        <div style="display:flex;justify-content:flex-end;">
                            <button type="submit"
                                    style="padding:10px 20px;background:#4CAF50;border:none;border-radius:6px;color:#fff;font-size:14px;font-weight:700;cursor:pointer;">댓글 등록</button>
                        </div>
                    </form>

                    <div style="height:1px;background:#E6E6E6;"></div>

                    <!-- 댓글 목록 -->
                    <div style="display:flex;flex-direction:column;gap:24px;">
                        <c:forEach var="comment" items="${comments}">
                            <div style="display:flex;flex-direction:column;gap:12px;">
                                <div style="display:flex;align-items:center;justify-content:space-between;">
                                    <div style="display:flex;align-items:center;gap:10px;">
                                        <div style="width:32px;height:32px;border-radius:50%;background:#F3F4F6;border:1px solid #E5E7EB;overflow:hidden;flex-shrink:0;">
                                            <c:if test="${not empty comment.authorProfileImage}">
                                                <img src="${comment.authorProfileImage}" alt="${comment.author}" style="width:100%;height:100%;object-fit:cover;">
                                            </c:if>
                                        </div>
                                        <div style="display:flex;flex-direction:column;gap:2px;">
                                            <span style="font-size:14px;font-weight:600;color:#1E1E1E;">${comment.author}</span>
                                            <span style="font-size:11px;color:#9CA3AF;">${comment.createdAt}</span>
                                        </div>
                                    </div>
                                    <c:if test="${comment.author == sessionScope.loginUser.nickname}">
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
                    <a href="${pageContext.request.contextPath}/community/list?type=${post.type}"
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
function toggleCommentEdit(id) {
    var textDiv = document.getElementById('comment-text-' + id);
    var formEl  = document.getElementById('comment-edit-' + id);
    var isHidden = formEl.style.display === 'none' || formEl.style.display === '';
    textDiv.style.display = isHidden ? 'none' : 'block';
    formEl.style.display  = isHidden ? 'flex' : 'none';
}
</script>
</body>
</html>
