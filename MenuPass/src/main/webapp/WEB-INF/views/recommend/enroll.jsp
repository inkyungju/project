<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <title>게시글 등록</title>
  	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/smarteditor2.jsp" %>
<link href="../../resources/css/mainMenu.css" rel="stylesheet">
<link href="../../resources/css/recommend.css" rel="stylesheet">
</head>
<body>
		<div id="mainMenu">
			<%@ include file="../common/mainMenu.jsp"%>
		</div>
	<div class="container" style="background-color: white;">

        <form action="insert.do" method="post" id="add-post-form" enctype="multipart/form-data">
        
            <div class="mb-3">
                <input type="text" class="form-control" id="title" name="recommend_Title" placeholder="음식이름">    
            </div>
            
            <div class="location">
                <input type="text" class="form-control" id="resName" name="restaurant_Name" placeholder="상호명">
                <input type="text" class="form-control" id="resAddr" name="restaurant_Addr" placeholder="주소">    
            </div>

            <div id="selectpoint">
                <select class="form-select" name="category_Food">
                    <option selected>음식을 골라주세요</option>
                    <option value="한식">한식</option>
                    <option value="중식">중식</option>
                    <option value="일식">일식</option>
                    <option value="양식">양식</option>
                    <option value="디저트">디저트</option>
                </select>

                <select class="form-select" name="recommend_Grade">
                    <option selected>별점을 선택해 주세요</option>
                    <option value="1">★</option>
                    <option value="2">★★</option>
                    <option value="3">★★★</option>
                    <option value="4">★★★★</option>
                    <option value="5">★★★★★</option>
                </select>
            </div>

<div id="smarteditor mb-3 justify-content-center">
<textarea name="recommend_Content" id="editorTxt" class="form-control" placeholder="내용을 입력해주세요"></textarea>
</div>
			<input type="file" name="upload"/>
<div class="row">
<div class="col text-center">
			<button type="button" class="btn1" onclick="history.back()">취소</button>
			<button type="submit" class="btn1" onclick="save()">등록</button>
</div>
</div> 
        </form>
        <%@ include file="../common/footer.jsp"%>
  </div>
  <!-- 네이버 스마트 에디터 -->
	<script type="text/javascript" src="/resources/js/common/smarteditor2.js" charset="utf-8"></script>
</body>
</html>
  <script>
	function submitForm(action) {
		const form = document.getElementById('add-post-form');
		console.log(form);
		form.action = action;
		save();
		form.submit();
	}
</script>
