<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko" class="h-100">

<head>
<%@ include file="../common/head.jsp"%>

<c:if test="${detail.memberNo == user }">
	<%@ include file="../common/smarteditor2.jsp"%>
</c:if>
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
			<div class="help">Commu Pass - Details</div>
			<hr>
			<br>

			<form id="form-submit" method="post" enctype="multipart/form-data">
				<input type="hidden" name="c_board_No" value="${detail.c_board_No}" />
				<div class="mb-3 justify-content-center">
					<input type="text" class="form-control" name="userTitle"
						value="${detail.userTitle}" id="exampleFormControlInput1"
						placeholder="제목을 입력하세요."
						${detail.memberNo != user ? 'readonly' : ''}>
				</div>

				<div class="mb-3 justify-content-center">
					<c:choose>
						<c:when test="${detail.memberNo == user}">

							<label for="categorySelect" class="form-label">카테고리</label>
							<select class="form-select" id="categorySelect" name="category">
								<option value="잡담">잡담</option>
								<option value="정보">정보</option>
								<option value="공유">공유</option>
							</select>
						</c:when>
						<c:otherwise>
							<div class="mb-3 justify-content-center">
								<label for="categorySelect" class="form-label">카테고리</label> 
								<input	class="form-select" id="categorySelect" name="category"
									value="${detail.category}" ${detail.memberNo != user ? 'readonly' : ''}></input>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				
				
				<div class="row">
					<div class="col-md-6">
						<label for="writeDateInput" class="form-label">작성일</label> <input
							type="text" class="form-control" id="writeDateInput" name="createDate"
							value="${detail.createDate}" readonly>
					</div>
					<div class="col-md-6">
						<label for="viewCountInput" class="form-label">조회수</label> <input
							type="number" class="form-control" id="viewCountInput" name="views"
							value="${detail.views}" readonly>
					</div>
				</div>
				<br>

				<div id="smarteditor mb-3 justify-content-center">
					<label for="editorTxt" class="form-label">내용</label>
					<c:choose>
						<c:when test="${detail.memberNo == user}">
							<textarea name="userContent" id="editorTxt" class="form-control"
								rows="13" cols="10" placeholder="내용을 입력해주세요">${detail.userContent}</textarea>
						</c:when>
						<c:otherwise>
							<div name="userContent" id="editorTxt" class="form-control" rows="13"
								cols="10" placeholder="내용을 입력해주세요" style="height: 300px;"
								readonly>${detail.userContent}</div>
						</c:otherwise>
					</c:choose>
				</div>
				<br>
				<input type="file" name="upload"/>
				<div class="row">
					<div class="col text-center">
						<button type="button" class="btn btn-light"
							onclick="history.back()">취소</button>
						<c:if test="${detail.memberNo == user}">
							<button type="button" onclick="submitForm('/commu/update.do')"
								class="btn btn-primary">수정</button>
							<button type="button" onclick="submitForm('/commu/delete.do')"
								class="btn btn-danger">삭제</button>
						</c:if>
					</div>
				</div>
			</form>

		</div>

	<%@ include file="../common/footer.jsp"%>
</body>
</html>
<script>
	function submitForm(action) {
		const form = document.getElementById('form-submit');
		console.log(form);
		form.action = action;
		save();
		form.submit();
	}
</script>