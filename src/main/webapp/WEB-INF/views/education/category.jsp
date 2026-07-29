<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 학습 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/category.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="category-main">
    <div class="category-page-inner">

        <div class="category-page-header">
            <h1 class="category-page-title">카테고리 학습</h1>
            <p class="category-page-subtitle">원하는 카테고리를 선택하여 집중 학습을 시작해보세요!</p>
        </div>

        <div class="category-grid">

            <!-- 변수 -->
            <a href="${pageContext.request.contextPath}/learn/category/variable" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="20" width="48" height="28" rx="4" stroke="#4CAF50" stroke-width="3"/>
                        <text x="14" y="40" font-size="18" font-weight="700" fill="#43A047" font-family="monospace">int a</text>
                    </svg>
                </div>
                <span class="category-card-name">변수</span>
                <span class="category-card-desc">기본적인 변수와 자료형</span>
            </a>

            <!-- 연산자 -->
            <a href="${pageContext.request.contextPath}/learn/category/operator" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <text x="8" y="40" font-size="36" font-weight="800" fill="#4CAF50" font-family="monospace">+-×</text>
                    </svg>
                </div>
                <span class="category-card-name">연산자</span>
                <span class="category-card-desc">연산자와 표현식</span>
            </a>

            <!-- 조건문 -->
            <a href="${pageContext.request.contextPath}/learn/category/condition" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M32 8 L56 32 L32 56 L8 32 Z" stroke="#4CAF50" stroke-width="3" fill="#EFFBEF"/>
                        <text x="22" y="37" font-size="14" font-weight="700" fill="#4CAF50">if</text>
                    </svg>
                </div>
                <span class="category-card-name">조건문</span>
                <span class="category-card-desc">if, switch 문</span>
            </a>

            <!-- 반복문 -->
            <a href="${pageContext.request.contextPath}/learn/category/loop" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 32 C12 20 20 12 32 12 C44 12 52 20 52 32" stroke="#4CAF50" stroke-width="3.5" stroke-linecap="round" fill="none"/>
                        <path d="M52 32 C52 44 44 52 32 52 C20 52 12 44 12 32" stroke="#4CAF50" stroke-width="3.5" stroke-linecap="round" fill="none" stroke-dasharray="4 4"/>
                        <polyline points="46,24 52,32 58,24" stroke="#4CAF50" stroke-width="3" stroke-linecap="round" fill="none"/>
                    </svg>
                </div>
                <span class="category-card-name">반복문</span>
                <span class="category-card-desc">for, while 문</span>
            </a>

            <!-- 배열 -->
            <a href="${pageContext.request.contextPath}/learn/category/array" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="6" y="22" width="16" height="20" rx="3" stroke="#4CAF50" stroke-width="3"/>
                        <rect x="24" y="22" width="16" height="20" rx="3" stroke="#4CAF50" stroke-width="3"/>
                        <rect x="42" y="22" width="16" height="20" rx="3" stroke="#4CAF50" stroke-width="3"/>
                        <text x="11" y="36" font-size="11" fill="#4CAF50" font-weight="700">0</text>
                        <text x="29" y="36" font-size="11" fill="#4CAF50" font-weight="700">1</text>
                        <text x="47" y="36" font-size="11" fill="#4CAF50" font-weight="700">2</text>
                    </svg>
                </div>
                <span class="category-card-name">배열</span>
                <span class="category-card-desc">1차원, 다차원 배열</span>
            </a>

            <!-- 메서드 -->
            <a href="${pageContext.request.contextPath}/learn/category/method" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="14" width="48" height="36" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <text x="14" y="32" font-size="11" fill="#4CAF50" font-weight="700" font-family="monospace">void</text>
                        <text x="14" y="45" font-size="11" fill="#43A047" font-weight="700" font-family="monospace">run()</text>
                    </svg>
                </div>
                <span class="category-card-name">메서드</span>
                <span class="category-card-desc">메서드의 선언부와 구현부</span>
            </a>

            <!-- 객체 -->
            <a href="${pageContext.request.contextPath}/learn/category/object" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="32" cy="32" r="20" stroke="#4CAF50" stroke-width="3"/>
                        <circle cx="32" cy="32" r="8" fill="#EFFBEF" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="32" y1="12" x2="32" y2="24" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="32" y1="40" x2="32" y2="52" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="12" y1="32" x2="24" y2="32" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="40" y1="32" x2="52" y2="32" stroke="#4CAF50" stroke-width="2"/>
                    </svg>
                </div>
                <span class="category-card-name">객체</span>
                <span class="category-card-desc">클래스와 객체</span>
            </a>

            <!-- 문자열 -->
            <a href="${pageContext.request.contextPath}/learn/category/string" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <text x="10" y="40" font-size="28" font-weight="700" fill="#4CAF50" font-family="serif">Abc</text>
                        <line x1="10" y1="46" x2="54" y2="46" stroke="#4CAF50" stroke-width="3" stroke-linecap="round"/>
                    </svg>
                </div>
                <span class="category-card-name">문자열</span>
                <span class="category-card-desc">String과 주요 메서드</span>
            </a>

            <!-- 상속 -->
            <a href="${pageContext.request.contextPath}/learn/category/inheritance" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="20" y="8" width="24" height="16" rx="4" stroke="#4CAF50" stroke-width="3"/>
                        <rect x="4" y="40" width="24" height="16" rx="4" stroke="#4CAF50" stroke-width="3"/>
                        <rect x="36" y="40" width="24" height="16" rx="4" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="32" y1="24" x2="32" y2="32" stroke="#4CAF50" stroke-width="2.5"/>
                        <line x1="16" y1="32" x2="48" y2="32" stroke="#4CAF50" stroke-width="2.5"/>
                        <line x1="16" y1="32" x2="16" y2="40" stroke="#4CAF50" stroke-width="2.5"/>
                        <line x1="48" y1="32" x2="48" y2="40" stroke="#4CAF50" stroke-width="2.5"/>
                    </svg>
                </div>
                <span class="category-card-name">상속</span>
                <span class="category-card-desc">상속과 다형성</span>
            </a>

            <!-- 인터페이스 -->
            <a href="${pageContext.request.contextPath}/learn/category/interface" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="6" y="8" width="52" height="48" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="6" y1="22" x2="58" y2="22" stroke="#4CAF50" stroke-width="2.5"/>
                        <line x1="6" y1="37" x2="58" y2="37" stroke="#4CAF50" stroke-width="2.5"/>
                        <circle cx="14" cy="15" r="3" fill="#4CAF50"/>
                        <circle cx="14" cy="29.5" r="3" fill="#4CAF50"/>
                        <circle cx="14" cy="50" r="3" fill="#4CAF50"/>
                    </svg>
                </div>
                <span class="category-card-name">인터페이스</span>
                <span class="category-card-desc">interface와 추상 클래스</span>
            </a>

            <!-- 예외 처리 -->
            <a href="${pageContext.request.contextPath}/learn/category/exception" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M32 8 L56 52 L8 52 Z" stroke="#4CAF50" stroke-width="3" stroke-linejoin="round" fill="#EFFBEF"/>
                        <line x1="32" y1="26" x2="32" y2="40" stroke="#4CAF50" stroke-width="4" stroke-linecap="round"/>
                        <circle cx="32" cy="47" r="3" fill="#4CAF50"/>
                    </svg>
                </div>
                <span class="category-card-name">예외 처리</span>
                <span class="category-card-desc">try-catch와 예외 처리</span>
            </a>

            <!-- 컬렉션 -->
            <a href="${pageContext.request.contextPath}/learn/category/collection" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="8" width="48" height="48" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <rect x="8" y="8" width="48" height="14" rx="4" fill="#EFFBEF" stroke="#4CAF50" stroke-width="0"/>
                        <line x1="16" y1="32" x2="48" y2="32" stroke="#4CAF50" stroke-width="2.5" stroke-linecap="round"/>
                        <line x1="16" y1="42" x2="48" y2="42" stroke="#4CAF50" stroke-width="2.5" stroke-linecap="round"/>
                        <line x1="16" y1="52" x2="36" y2="52" stroke="#4CAF50" stroke-width="2.5" stroke-linecap="round"/>
                    </svg>
                </div>
                <span class="category-card-name">컬렉션</span>
                <span class="category-card-desc">List, Set, Map</span>
            </a>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
