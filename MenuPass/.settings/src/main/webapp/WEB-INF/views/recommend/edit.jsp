<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>게시글 수정</title>
<%@ include file="../common/head.jsp"%>
<%@ include file="../common/smarteditor2.jsp"%>
<link href="../../resources/css/mainMenu.css" rel="stylesheet">
<link href="../../resources/css/recommend.css" rel="stylesheet">
</head>
<body>
	<div id="mainMenu">
		<%@ include file="../common/mainMenu.jsp"%>
	</div>
	<div class="container" style="background-color: white;">

		<form action="update.do" method="post" id="edit-post-form"  enctype="multipart/form-data">
			<input type="hidden" name="board_No" value="${detail.board_No}" />
			
			<div class="mb-3">
				<input type="text" class="form-control" name="recommend_Title"
					value="${detail.recommend_Title}" id="exampleFormControlInput1"
					placeholder="제목을 입력하세요." ${1 != user ? 'readonly' : ''} />
			</div>
			
			<div class="location">
                <input type="text" class="form-control" value="${detail.restaurant_Name}" id="resName" name="restaurant_Name" placeholder="상호명" ${1 != user ? 'readonly' : ''}/>
                <input type="text" class="form-control" value="${detail.restaurant_Addr}" id="resAddr" name="restaurant_Addr" placeholder="주소" ${1 != user ? 'readonly' : ''}/>    
            </div>
			
			<c:choose>
				<c:when test="${1 == user}">
			<div id="selectpoint">
			<select class="form-select" name="category_Food">
				<option selected>${detail.category_Food}</option>
				<option value="한식">한식</option>
				<option value="중식">중식</option>
				<option value="일식">일식</option>
				<option value="양식">양식</option>
				<option value="디저트">디저트</option>
			</select>
			
			<select class="form-select" name="recommend_Grade">
				<c:forEach var="i" begin="1" end="5">
					<option value="${i}" ${i == detail.recommend_Grade ? 'selected' : ''}>
						<c:choose>
							<c:when test="${i == 1}">★</c:when>
							<c:when test="${i == 2}">★★</c:when>
							<c:when test="${i == 3}">★★★</c:when>
							<c:when test="${i == 4}">★★★★</c:when>
							<c:when test="${i == 5}">★★★★★</c:when>
						</c:choose>
					</option>
				</c:forEach>
			</select>
		</div>
					</c:when>
						<c:otherwise>
						<div id="selectpoint">
							<input class="form-select" name="category_Food" value="${detail.category_Food}" ${1 != user ? 'readonly' : ''} />
							<input class="form-select" name="recommend_Grade" value="${detail.recommend_Grade}" ${1 != user ? 'readonly' : ''} />	
						</div>
						</c:otherwise>
				</c:choose>
			<div class="row">
				<div class="col-md-4">
						<label for="writeUserNameInput" class="form-label">작성자</label> <input
							type="text" class="form-control" id="writeDateInput" name="memberName"
							value="${detail.memberName}" readonly>
					</div>
					
					<div class="col-md-4">
						<label for="writeDateInput" class="form-label">작성일</label> <input
							type="text" class="form-control" id="writeDateInput" name="createDate"
							value="${detail.createDate}" readonly>
					</div>
					<div class="col-md-4">
						<label for="viewCountInput" class="form-label">조회수</label> <input
							type="number" class="form-control" id="viewCountInput" name="views"
							value="${detail.views}" readonly>
					</div>
				</div>
					<c:choose>
					    <c:when test="${not empty detail.uploadName}">
					        <img src="../../resources/upload/${detail.uploadName}">
					    </c:when>
					    <c:otherwise>
					    <br>
					        <p> 사진이 없습니다 </p>
					        <br>
					    </c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${1 == user}">
						<div id="smarteditor">
							<textarea name="recommend_content" id="editorTxt" class="form-control"
								rows="13" cols="10" placeholder="내용을 입력해주세요">${detail.recommend_Content}</textarea>
						</div>
						</c:when>
						<c:otherwise>
							<textarea id="content" name="recommend_Content" type="text" readonly>${detail.recommend_Content}</textarea>
						</c:otherwise>
					</c:choose>
				<br>
				
			<c:choose>
				 <c:when test="${1 == user}">
					<div type="file" name="upload">업로드 파일 이름 : ${detail.uploadName}</div>
					<input type="file" name="upload" />
				</c:when>
					<c:otherwise>	
						
					</c:otherwise>
			</c:choose>
		<div class="row">
		<div class="col text-center">
			<c:choose>
				<c:when test="${1 == user}">
				<button type="button" class="btn1" onclick="deleteCommu()">삭제</button>
				<button type="button" class="btn1" onclick="history.back()">취소</button>
				<button type="submit" class="btn1" onclick="submitForm('update.do')">수정</button>
				</c:when>
			<c:otherwise>
				<button type="button" class="btn1" onclick="history.back()">뒤로가기</button>
			</c:otherwise>
			</c:choose>
			</div>
			</div>
	</form>

	<%@ include file="../common/footer.jsp"%>
</div>

<script>
//게시글 삭제 버튼 클릭 시 호출되는 함수
function deleteCommu() {
    const form = document.getElementById('edit-post-form');
    form.action = 'delete.do'; // 삭제 요청을 보낼 URL 설정
    form.submit(); // 폼 전송
}


//수정 버튼 클릭 시 호출되는 함수
function submitForm(action) {
    const form = document.getElementById('edit-post-form');
    save();
    form.action = action;
}
//스마트 에디터로 작성된 내용에서 <p> 태그를 제거하여 추출하는 함수
function removePTagsAndShowContent() {
  // 추출하고자 하는 내용을 가져옵니다.
  var content = "${detail.recommend_Content}";

  // <p> 태그를 제거합니다.
  var contentWithoutPTags = content.replace(/<\/?p>/g, '');

  // textarea 엘리먼트를 가져옵니다.
  var textarea = document.getElementById('content');

  // textarea에 내용을 설정합니다.
  textarea.value = contentWithoutPTags;
}

// 함수 호출
removePTagsAndShowContent();

</script>

</body>
</html>