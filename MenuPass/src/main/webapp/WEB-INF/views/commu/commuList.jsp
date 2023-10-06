<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko" class="h-100">
<head>
<%@ include file="../common/head.jsp"%>
<!-- boardList.css 파일 불러오기 -->
<link href="../../resources/css/boardList.css" rel="stylesheet">
<link href="../../resources/css/mainMenu.css" rel="stylesheet">

</head>
<body class="flex-column h-100">
	<div id="mainMenu">
		<%@ include file="../common/mainMenu.jsp"%>
	</div>
	<%@ include file="../common/minigame.jsp"%>
				<br>
		<div class="container" style="width: 1000px;">
			<div class="help">Commu Pass</div>
				<hr>
				<br />
				<table class="table table-hover">
					<thead>
						<tr>
							<td>선택</td>
							<td>번호</td>
							<td>카테고리</td>
							<td>제목</td>
							<td>작성자</td>
							<td>작성일</td>
							<td>조회수</td>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list}">
							<tr>
								<td colspan="7"><h3 class="text-center">등록된 글이 없습니다.</h3></td>
							</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="item" items="${list}">
								
									<tr onclick="location.href='detail.do?c_board_No=${item.c_board_No}'">
									<td>
				           			 <input type="checkbox" name="itemCheckbox" onclick="event.stopPropagation();" />
				        			</td>
									<td>${row}</td>
									<td>${item.category}</td>
									<td>${item.userTitle}</td>
									<td>${item.memberName}</td>
									<td>${item.createDate}</td>
									<td>${item.views}</td>
									</tr>
		 				<c:set var="row" value="${row-1}" />
		 			</c:forEach>
		 		</c:otherwise>
		 	</c:choose>
		 </tbody>

					<div class="d-grid gap-2d-md-flex justify-content-end float-right ">
						<button class="btn me-md-2" type="button"
							onclick="location.href='enrollForm.do';">글쓰기</button>
					</div>
				</table>


			<nav aria-label="Page navigation example ">
				  <ul class="pagination justify-content-center">
				  	<c:choose>
				  		<c:when test="${ pi.currentPage eq 1 }">
						    <li class="page-item">
						      <a class="page-link" href="#" aria-label="Previous">
						        <span aria-hidden="true">처음</span>
						      </a>
						    </li>
						    <li class="page-item">
						      <a class="page-link" href="#" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
					    </c:when>
					    <c:otherwise>
					     	<li class="page-item">
						      <a class="page-link" href="list.do?cpage=${ pi.startPage -1 }" aria-label="Previous">
						        <span aria-hidden="true">처음</span>
						      </a>
						    </li>
							<li class="page-item">
						      <a class="page-link" href="list.do?cpage=${ pi.currentPage - 1}" aria-label="Previous">                                        
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
					    </c:otherwise>
				    </c:choose>
				    
				    <c:forEach var="page" begin="${pi.startPage}" end="${pi.endPage}">
					    <li class="page-item">
					    	<a class="page-link" href="list.do?cpage=${page}">${page}</a>
					    </li>
				    </c:forEach>
				    
				    <c:choose>
				    	<c:when test="${pi.currentPage eq pi.maxPage}">                           
						    <li class="page-item">
						      <a class="page-link" href="#" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
						    <li class="page-item">
						      <a class="page-link" href="#" aria-label="Next">
						        <span aria-hidden="true">끝</span>
						      </a>
						    </li>
					    </c:when>
					    <c:otherwise>
						    <li class="page-item">
						      <a class="page-link" href="list.do?cpage=${pi.endPage + 1}" aria-label="Next">                                 
						        <span aria-hidden="true">&raquo;</span> 
						      </a>
						    </li>
					    	<li class="page-item">
						      <a class="page-link" href="list.do?cpage=${pi.currentPage + 1}" aria-label="Next">                                 
						        <span aria-hidden="true">끝</span> 
						      </a>
						    </li>
					    </c:otherwise>
				    </c:choose>
				  </ul>
				</nav>
				
				
		  </div>
		<%@ include file="../common/footer.jsp" %>
  	</body>
</html>
