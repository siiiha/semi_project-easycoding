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

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=37" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="14" width="48" height="36" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <text x="14" y="38" font-size="14" font-weight="700" fill="#43A047" font-family="monospace">JAVA</text>
                    </svg>
                </div>
                <span class="category-card-name">Java기본</span>
                <span class="category-card-desc">자료형,연산자,제어문,메서드</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=38" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="32" cy="32" r="20" stroke="#4CAF50" stroke-width="3"/>
                        <text x="20" y="37" font-size="12" font-weight="700" fill="#43A047" font-family="monospace">OOP</text>
                    </svg>
                </div>
                <span class="category-card-name">객체지향</span>
                <span class="category-card-desc">상속,다향성,추상화,캡슐화</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=39" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="10" width="48" height="44" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="8" y1="24" x2="56" y2="24" stroke="#4CAF50" stroke-width="2"/>
                    </svg>
                </div>
                <span class="category-card-name">클래스</span>
                <span class="category-card-desc">인터페이스,추상클래스,중첩클래스</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=40" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M32 8 L56 52 L8 52 Z" stroke="#4CAF50" stroke-width="3" stroke-linejoin="round" fill="#EFFBEF"/>
                        <line x1="32" y1="26" x2="32" y2="40" stroke="#4CAF50" stroke-width="4" stroke-linecap="round"/>
                        <circle cx="32" cy="47" r="3" fill="#4CAF50"/>
                    </svg>
                </div>
                <span class="category-card-name">예외처리</span>
                <span class="category-card-desc">try-catch-finally,throw,throws</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=41" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="8" width="48" height="48" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="16" y1="24" x2="48" y2="24" stroke="#4CAF50" stroke-width="2.5" stroke-linecap="round"/>
                        <line x1="16" y1="34" x2="48" y2="34" stroke="#4CAF50" stroke-width="2.5" stroke-linecap="round"/>
                        <line x1="16" y1="44" x2="48" y2="44" stroke="#4CAF50" stroke-width="2.5" stroke-linecap="round"/>
                    </svg>
                </div>
                <span class="category-card-name">컬렉션</span>
                <span class="category-card-desc">List,Set,Map,Queue,Iterator</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=42" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="14" width="48" height="36" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <text x="16" y="38" font-size="12" font-weight="700" fill="#43A047" font-family="monospace">T&lt;?&gt;</text>
                    </svg>
                </div>
                <span class="category-card-name">제네릭</span>
                <span class="category-card-desc">타입매개변수,타입소거,와일드카드</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=43" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="10" y="12" width="44" height="40" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <text x="19" y="37" font-size="12" font-weight="700" fill="#43A047" font-family="monospace">JVM</text>
                    </svg>
                </div>
                <span class="category-card-name">JVM</span>
                <span class="category-card-desc">메모리구조,GC,클래스로딩</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=44" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="20" cy="20" r="7" stroke="#4CAF50" stroke-width="3"/>
                        <circle cx="44" cy="20" r="7" stroke="#4CAF50" stroke-width="3"/>
                        <circle cx="32" cy="44" r="7" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="26" y1="24" x2="38" y2="24" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="24" y1="26" x2="29" y2="37" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="40" y1="26" x2="35" y2="37" stroke="#4CAF50" stroke-width="2"/>
                    </svg>
                </div>
                <span class="category-card-name">동시성</span>
                <span class="category-card-desc">스레드,synchronized,volatile,executor</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=45" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M10 44 L26 20 L38 36 L54 16" stroke="#4CAF50" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <span class="category-card-name">함수형Java</span>
                <span class="category-card-desc">람다,Stream,Optional</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=46" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="12" width="48" height="40" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="8" y1="24" x2="56" y2="24" stroke="#4CAF50" stroke-width="2"/>
                    </svg>
                </div>
                <span class="category-card-name">프론트엔드</span>
                <span class="category-card-desc">HTML,CSS,JavaScript</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=47" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="6" y="16" width="52" height="32" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <circle cx="18" cy="32" r="3" fill="#4CAF50"/>
                        <circle cx="28" cy="32" r="3" fill="#4CAF50"/>
                        <circle cx="38" cy="32" r="3" fill="#4CAF50"/>
                    </svg>
                </div>
                <span class="category-card-name">백엔드</span>
                <span class="category-card-desc">Spring,SpringBoot,MyBatis,JPA</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=48" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <ellipse cx="32" cy="16" rx="18" ry="8" stroke="#4CAF50" stroke-width="3"/>
                        <path d="M14 16 V42 C14 46 22 50 32 50 C42 50 50 46 50 42 V16" stroke="#4CAF50" stroke-width="3" fill="none"/>
                    </svg>
                </div>
                <span class="category-card-name">데이터베이스</span>
                <span class="category-card-desc">관계형DB,트랜잭션,정규화</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=49" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="32" cy="32" r="20" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="12" y1="32" x2="52" y2="32" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="32" y1="12" x2="32" y2="52" stroke="#4CAF50" stroke-width="2"/>
                    </svg>
                </div>
                <span class="category-card-name">네트워크</span>
                <span class="category-card-desc">TCP/IP,HTTP,HTTPS,Socket</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=50" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="8" y="10" width="48" height="44" rx="6" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="8" y1="24" x2="56" y2="24" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="24" y1="24" x2="24" y2="54" stroke="#4CAF50" stroke-width="2"/>
                    </svg>
                </div>
                <span class="category-card-name">운영체제</span>
                <span class="category-card-desc">프로세스,스레드,메모리관리</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=51" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="6" y="10" width="16" height="16" rx="3" stroke="#4CAF50" stroke-width="3"/>
                        <rect x="24" y="10" width="16" height="16" rx="3" stroke="#4CAF50" stroke-width="3"/>
                        <rect x="42" y="10" width="16" height="16" rx="3" stroke="#4CAF50" stroke-width="3"/>
                        <line x1="14" y1="28" x2="32" y2="46" stroke="#4CAF50" stroke-width="2"/>
                        <line x1="50" y1="28" x2="32" y2="46" stroke="#4CAF50" stroke-width="2"/>
                        <circle cx="32" cy="50" r="6" stroke="#4CAF50" stroke-width="3"/>
                    </svg>
                </div>
                <span class="category-card-name">자료구조</span>
                <span class="category-card-desc">배열,연결리스트,스택,큐,트리,그래프</span>
            </a>

            <a href="${pageContext.request.contextPath}/education/category/quiz?categoryId=52" class="category-card">
                <div class="category-card-icon-wrap">
                    <svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M32 8 L50 14 V30 C50 42 41 51 32 56 C23 51 14 42 14 30 V14 Z" stroke="#4CAF50" stroke-width="3" fill="#EFFBEF"/>
                        <rect x="24" y="28" width="16" height="12" rx="2" stroke="#4CAF50" stroke-width="2"/>
                    </svg>
                </div>
                <span class="category-card-name">보안</span>
                <span class="category-card-desc">암호화,인증,인가,XSS,CSRF</span>
            </a>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
