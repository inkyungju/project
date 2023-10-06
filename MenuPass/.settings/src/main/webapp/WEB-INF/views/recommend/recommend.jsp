<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../common/head.jsp"%>
<link href="../../resources/css/mainMenu.css" rel="stylesheet">
<link href="../../resources/css/recommend.css" rel="stylesheet">
</head>
<body>
	<div id="mainMenu">
		<%@ include file="../common/mainMenu.jsp"%>
	</div>
	<div class="container">
			<%@ include file="../common/header.jsp"%>
			<%@ include file="../common/minigame.jsp"%>
				<br>
				<div class="help">Recommend Pass</div>
				<hr>
				<main class= "page-content">		
			<c:choose>
				<c:when test="${empty list}">
				<br>
					<tr>
						<td colspan="5"><h3 class="text-center">등록된 글이 없습니다.</h3></td>
					</tr>
					<br>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${list}">
								<div class="card" style="background-image: url(../../resources/upload/${item.uploadName});">
									<div class="content">
										<h2 class="title">${item.recommend_Title}</h2>
										<span class="restaurant_Name">${item.restaurant_Name}</span>
										<span class="restaurant_Addr">${item.restaurant_Addr}</span>
										<div class="grade">평점 : ${item.recommend_Grade}</div>
										<button class="btn" onclick="location.href='detail.do?board_No=${item.board_No}'">자세히</button>
									</div>
								</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</main>
				<div class="footer">
					<button class="btn btn-secondary" id="load" >더 보기</button>
				</div>

		<%@ include file="../common/footer.jsp"%>
	</div>
		<script src="../../resources/js/recommend.js"></script>
		
</body>
</html>