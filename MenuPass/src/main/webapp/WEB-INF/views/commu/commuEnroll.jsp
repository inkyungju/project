<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!doctype html>
<html lang="ko" class="h-100">
	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/smarteditor2.jsp" %>
	<link href="../../resources/css/mainMenu.css" rel="stylesheet">

</head>
<body class="flex-column h-100">

	<div id="mainMenu">
		<%@ include file="../common/mainMenu.jsp"%>
	</div>
	  <%@ include file="../common/minigame.jsp"%>
		<!-- Begin page content -->
	<br>
		  <div class="container" style="width: 1000px;">
		<div class="help">Commu Pass - Writing</div>
		<hr>
		<br>
		
		<form action="insert.do" method="post" enctype="multipart/form-data">
			<div class="mb-3 justify-content-center">
				<label for="exampleFormControlInput1" class="form-label">제목</label>
				<input type="text" class="form-control"
					   name="userTitle"
					   id="exampleFormControlInput1" placeholder="제목을 입력하세요."/>
			</div>
			
			<div class="mb-3 justify-content-center">
			    <label for="categorySelect" class="form-label">카테고리</label>
			    <select class="form-select" id="categorySelect" name="category">
			        <option value="잡담">잡담</option>
			        <option value="정보">정보</option>
			        <option value="공유">공유</option>
			    </select>
			</div>
			
			<div id="smarteditor mb-3 justify-content-center">
				<label for="editorTxt" class="form-label">내용</label>
				<textarea name="userContent" id="editorTxt"
						  class="form-control"
						  rows="13" cols="10"
						  placeholder="내용을 입력해주세요"></textarea>
				</div>
				
				<input type="file" name="upload"/>
				
				<div class="row">	
				<div class="col text-center">
					<button type="button" class="btn btn-danger" onclick="history.back()">취소</button>
					<button type="submit" class="btn btn-primary" onclick="save()">작성</button>
				</div>
		</form>

		<%@ include file="../common/footer.jsp" %>
	</div>
  	</body>
</html>
