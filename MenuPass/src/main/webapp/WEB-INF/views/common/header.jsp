<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		
		<header>
			<c:choose>
			<c:when test="${user == 1}">
			   <nav>
			      <div class="btn-group">
			         <button type="button" class="btn " id="add-post-form" onclick="location.href='enroll.do'">글쓰기</button>
			         <button type="button" class="btn " id="toggle-search-button">검색</button>
			      </div>
			         <div id="search-container" style="text-align: -webkit-right; justify-content: flex-end; display: none;">
			            <input class="form-control" type="search" placeholder="search" aria-label="Search" id="search-input" style="width: auto; ">
			         </div>
			   </nav>
			   </c:when>
			   <c:otherwise>
			   <nav>
			      <div class="btn-group">
			         <button type="button" class="btn " id="toggle-search-button">검색</button>
			      </div>
			         <div id="search-container" style="text-align: -webkit-right; justify-content: flex-end; display: none;">
			            <input class="form-control" type="search" placeholder="search" aria-label="Search" id="search-input" style="width: auto; ">
			         </div>
			   </nav>
			   </c:otherwise>
			   </c:choose>
			</header>
		
<script>
   // 검색 버튼 요소 가져오기
   var toggleSearchButton = document.getElementById('toggle-search-button');
   
   // 검색창 요소 가져오기
   var searchContainer = document.getElementById('search-container');
   
   // 검색어 입력 필드 가져오기
   var searchInput = document.getElementById('search-input');
   
   // 버튼 클릭 이벤트 처리
   toggleSearchButton.addEventListener('click', function() {
       // 검색창의 현재 display 속성 가져오기
       var searchContainerDisplay = window.getComputedStyle(searchContainer).getPropertyValue('display');
       
       // 검색창의 display 속성 변경하기
       if (searchContainerDisplay === 'none') {
           searchContainer.style.display = 'flex'; // 원하는 스타일로 변경
       } else {
           searchContainer.style.display = 'none';
       }
   });
   
   // 검색어 입력 시 이벤트 리스너 등록
   searchInput.addEventListener('input', function() {
       searchPosts();
   });

   // 게시글 검색 함수
   function searchPosts() {
       // 검색어를 소문자로 변환
       var searchInputValue = searchInput.value.toLowerCase();
       // 게시글 카드 요소들 가져오기 (수정 필요)
       var posts = document.getElementsByClassName('card'); // 게시글 카드 클래스명에 맞게 수정

       // 모든 게시글 순회
       for (var i = 0; i < posts.length; i++) {
           var post = posts[i];
           // 게시글 제목과 내용 가져오기
           var postTitle = post.querySelector('.title').textContent.toLowerCase();
           var postContent = post.querySelector('.content').textContent.toLowerCase();
           var postResName = post.querySelector('.restaurant_Name').textContent.toLowerCase();
           var postResAddr = post.querySelector('.restaurant_Addr').textContent.toLowerCase();
           // 검색어와 일치하는 게시글인 경우 표시, 아닌 경우 숨김
           if (postTitle.includes(searchInputValue) || postContent.includes(searchInputValue) ||
        	   postResName.includes(searchInputValue) || postResAddr.includes(searchInputValue)) {
               post.style.display = 'block';
           } else {
               post.style.display = 'none';
           }
       }
   }
</script>