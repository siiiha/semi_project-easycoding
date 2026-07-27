<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang=ko>
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의하기 - 쉽코딩</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/service_inquiry.css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="title-area">
		<h1 class="title">개발 준비 중입니다.</h1>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>