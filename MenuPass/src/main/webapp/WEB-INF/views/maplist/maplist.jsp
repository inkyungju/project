<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="false" %>
<% pageContext.setAttribute("replaceChar", "<br>"); %>
<!DOCTYPE html>
<html>
<head>

<%@ include file="../common/head.jsp"%>
    <meta charset="utf-8">
    <title>키워드로 장소검색하고 목록으로 표출하기</title>
<link href="../../resources/css/weather.css" rel="stylesheet">
<link href="../../resources/css/mainMenu.css" rel="stylesheet">
<link href="../../resources/css/maplist.css" rel="stylesheet">
</head>
		<body>
	
			<div id="mainMenu"> <!-- 메인메뉴 -->
		<%@ include file="../common/mainMenu.jsp"%>

		
		</div>		
		<div class="help">Today's weather</div>
		<hr>
		<%@ include file="../common/weather.jsp"%>
	<br>
	<div class="help">New Food Cataloged</div>
	<hr>
	<div class="card-container">
    							<div class='slide-track'>
    							<c:forEach var="item" items="${list}">
									<div class="slide" onclick="location.href='/recommend/detail.do?board_No=${item.board_No}'">
									<div class="train-card" style="background-image: url(../../resources/upload/${item.uploadName});">
										<div class="card-section">
										<h2 class="title" style="margin-bottom: 0px; ">${item.restaurant_Name}</h2>
										<span class="restaurant_Addr">${item.restaurant_Addr}</span>
										</div>
									</div>
									</div>
									</c:forEach>
									</div>
									</div>

		<div class="help">Map Search</div>
		<hr>
			<!--검색바-->
		<div class="search-bar" style="margin-left: 430px;">
		  <form onsubmit="searchPlaces(); return false;">
		    <div style="display: flex; align-items: center;">
		      <input type="text" placeholder="음식 또는 식당명을 입력하세요." id="keyword" size="40" 
		      		 style="width: 300px; height: 40px; border-radius: 40px; background-color: #F2F2F2; font-size: 15px; border: none; font-weight: 200; color: #848484; padding-right: 10px; padding-left: 20px;">
		      <div style="background: none; border: none; vertical-align: middle; margin-left: -30px; margin-top: 5px; cursor: pointer;" onclick="searchPlaces();">
		        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style="margin-left: -10px;">
		          <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
		        </svg>
		      </div>
		    </div>
		  </form>
		</div> 
		<br>

		        <!--지도-->
			<div class="map_wrap">
   				<div id="map"></div>
         		<!--리스트-->
     		  <ul id="placesList" padding: 5px; border-radius: 20px;"></ul>
		      <!-- 페이징 버튼 -->
       		 <div id="pagination"> 
    	</div>
	 </div>

			  <!-- 모달 창 -->
		<div id="modal" class="modal">
		  <div class="modal-content">
		    <span class="close-btn2" onclick="closeModal()">&times;</span>
		    <!-- 모달 내용을 보여줄 영역 -->
		    <div id="modal-content-area" class="address-line"></div>
		  </div>
		</div>
		<br>
		
		<%@ include file="../common/footer.jsp"%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=?=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
var resultData;

//모달 창 보여주기
function showModal() {
  var modal = document.getElementById('modal');
  modal.style.display = 'block';
}

// 모달 창 닫기
function closeModal() {
  var modal = document.getElementById('modal');
  modal.style.display = 'none';
}

// 모달 내용
function showPlaceInfo(clickedData) {
		const restaurantName = clickedData.place_name;
	$.ajax({
          url: "/maplist/rating.do", 
          type: 'POST',
          data: {restaurantName : restaurantName}, 
          success: function(response) {
        	  selectRating2(response);
          },
          error: function() {
            console.error('별점 전송 실패');
          }
        });
	
	var modalContentArea = document.getElementById('modal-content-area');
	  var reviewsHTML = '';
	  var modalContentHTML = ''; 
	  var reviewText = "후기 정보가 없습니다.";
	  
	  for (var i = 0; i < resultData.length; i++) {
		  
		   var review = resultData[i];
		  // 클릭한 레스토랑 아이디랑 resultData 아이디랑 동일할 때,if문 실행해서 리뷰 가지고 오기
		 
		  if(clickedData.place_name === resultData[i].restaurantName) {
		  
		  
		  if (review.memberName){
			  reviewsHTML += '<div class="review-info-image-container">';
		      reviewsHTML += '<div class="review-image"><img src="/resources/image/유저1.png"></div>';
		      reviewsHTML += '<div class="review-info">' + review.memberName + '</div>';
		      reviewsHTML += '<div class="star-icon star-selected">' + getStarIcons(review.restaurantRating) + '</div>';
		      reviewsHTML += '</div>'; // review-info-image-container 닫기
		    }
		 
		 	 
		  
		  if (review.restaurantName === clickedData.place_name && review.restaurantReview) {
			  reviewsHTML += '<div class="review-entry">';
			    
			 // 업로드된 이미지 추가
			    if (review.uploadName != undefined) {
			        reviewsHTML += '<div class="review-upload" style="margin-right: 10px;">';
			        reviewsHTML += '<img src="/resources/upload/' + review.uploadName + '" width="100" height="100" style="border-radius: 20%;">';
			        reviewsHTML += '</div>';
			    }

			   
			      reviewsHTML += '<div class="review-content">' + review.restaurantReview + '</div>'; 


			    // 수정 및 삭제 버튼 추가
			    reviewsHTML += '<div class="button-container">';
			    reviewsHTML += '<button class="edit-button" onclick="showEditReviewForm(\'' + review.reviewId + '\')">수정</button>';
			    reviewsHTML += '<button class="delete-button" onclick="showDeleteReviewConfirmation(\'' + review.reviewId + '\')">삭제</button>';
			    reviewsHTML += '</div>';

			    reviewsHTML += '</div>'; // review-entry 닫기
			    reviewsHTML += '<br>';
			  }
			}
	 	 }
	  
	  

	
  if (reviewsHTML !== '' ) {
	  
	  modalContentHTML = `
		  <div class="info-container">
		  <p><img src="/resources/image/가게.jpg" width="15" height="15">
		  <b style="color: #424242; font-weight: 400;">상호명 :</b>` + clickedData.place_name +`</p>
		  <p><img src="/resources/image/지도.jpg" width="15" height="15">
		  <b style="color: #424242; font-weight: 400;">주소 :</b> ` + clickedData.road_address_name +`</p>
		  <p><img src="/resources/image/전화.jpg" width="15" height="15">
		  <b style="color: #424242; font-weight: 400;">전화번호 :</b> ` + clickedData.phone +`</p>
		  <p><img src="/resources/image/음식.jpg" width="15" height="15">
		  <b style="color: #424242; font-weight: 400;">종류 :</b> ` + clickedData.category_name +`</p>
		  <p><img src="/resources/image/후기.jpg" width="15" height="15">
		  <b style="color: #424242; font-weight: 400;">후기 </b><button id="writeReviewButton" class="write-button" onclick="showModalReviewForm('`+clickedData.place_name+`','`+clickedData.road_address_name+`','`+clickedData.phone+`','`+clickedData.category_name+`')">후기 작성
		  <img src="/resources/image/pen.png"></button> <br><br> ` + reviewsHTML + `</p>
		  </div>
	  `;
	  
	  
	  } else {
	  modalContentHTML = `
		  <div class="info-container">
        <p><img src="/resources/image/가게.jpg" width="15" height="15">
        <b style="color: #424242; font-weight: 400;">상호명 :</b> ` + clickedData.place_name +`</p>
        <p><img src="/resources/image/지도.jpg" width="15" height="15">
        <b style="color: #424242; font-weight: 400;">주소 :</b> ` + clickedData.road_address_name +`</p>
        <p><img src="/resources/image/전화.jpg" width="15" height="15">
        <b style="color: #424242; font-weight: 400;">전화번호 :</b> ` + clickedData.phone +`</p>
        <p><img src="/resources/image/음식.jpg" width="15" height="15">
        <b style="color: #424242; font-weight: 400;">종류 :</b> ` + clickedData.category_name +`</p>
        <p><img src="/resources/image/후기.jpg" width="15" height="15">
        <b style="color: #424242; font-weight: 400;">후기 </b> <button id="writeReviewButton" class="write-button" onclick="showModalReviewForm('`+clickedData.place_name+`','`+clickedData.road_address_name+`','`+clickedData.phone+`','`+clickedData.category_name+`')">후기 작성
		  <img src="/resources/image/pen.png"></button> ${reviewText}</p>
        </div>
	    `;
	  }

	  modalContentArea.innerHTML = modalContentHTML;

// 후기 작성 폼이 보이도록 설정
	  /* var reviewFormHTML = `
		  <button id="writeReviewButton" class="write-button" onclick="showModalReviewForm('`+clickedData.place_name+`','`+clickedData.road_address_name+`','`+clickedData.phone+`','`+clickedData.category_name+`')">후기 작성
		  <img src="/resources/image/pen.png"></button> 
		`;

	  modalContentHTML += reviewFormHTML; */
	  modalContentArea.innerHTML = modalContentHTML;
	  showModal();
}


//후기 작성 폼 보여주기
function showModalReviewForm(place_name, road_address_name, phone, category_name) {


var modalContentArea = document.getElementById('modal-content-area');
var reviewFormHTML = `
<div id="addReviewForm">
  <h3>별점과 후기를 남겨주세요.</h3>
  <br>
  <form id="reviewForm" action="/maplist/addreview.do" method="post" enctype="multipart/form-data">
  <div id="ratingContainer">
      <span class="star-icon" onclick="selectRating(1)" data-rating="1">&#9733;</span>
      <span class="star-icon" onclick="selectRating(2)" data-rating="2">&#9733;</span>
      <span class="star-icon" onclick="selectRating(3)" data-rating="3">&#9733;</span>
      <span class="star-icon" onclick="selectRating(4)" data-rating="4">&#9733;</span>
      <span class="star-icon" onclick="selectRating(5)" data-rating="5">&#9733;</span>
  </div>
  <br>
  <br>
  <input type="hidden" id="selectedRatingInput" name="restaurantRating">
  <input type="hidden" value="`+place_name+`" name="restaurantName">
  <input type="hidden" value="`+road_address_name+`" name="restaurantAddress">
  <input type="hidden" value="`+phone+`" name="restaurantPhone">
  <input type="hidden" value="`+category_name+`" name="restaurantCuisine">
  	<textarea id="reviewTextArea" name="restaurantReview" rows="4" cols="50" placeholder="후기를 입력하세요."></textarea>
  	<br>
  	<br>
  	<h3>사진 첨부하기</h3>
    <input type="file" id="imageUploadInput" name="reviewImage">
    <button id="submitReviewButton" type="submit">작성</button>
  </form>
</div>
`;

modalContentArea.innerHTML = reviewFormHTML;
document.getElementById('submitReviewButton').style.display = 'block'; // 작성 버튼 활성화
document.getElementById('showModalReviewFormButton').style.display = 'none'; // 수정한 버튼 ID 사용
document.getElementById('writeReviewButton').style.display = 'block';

}
// 별점 기능
var selectedRating = 0;

//별점 선택을 처리하는 함수를 정의합니다.
function selectRating(restaurantRating) {
	
	selectedRating = restaurantRating;
	updateStarIcons();
}
//별점 선택을 처리하는 함수를 정의합니다.
function selectRating2(restaurantRating) {
	
	selectedRating = restaurantRating;
	updateStarIcons2();
}
//별점 아이콘을 업데이트하는 함수를 정의합니다.
function updateStarIcons() {
var starIcons = document.querySelectorAll('.star-icon');
for (var i = 0; i < starIcons.length; i++) {
 if (i < selectedRating) {
	document.getElementById("selectedRatingInput").value = i+1;
   starIcons[i].classList.add('selected');
 } else {
   starIcons[i].classList.remove('selected');
 }
}
}

function updateStarIcons2() {
	var starIcons = document.querySelectorAll('.star-icon');
	for (var i = 0; i < starIcons.length; i++) {
	 if (i < selectedRating) {
	   starIcons[i].classList.add('selected');
	 } else {
	   starIcons[i].classList.remove('selected');
	 }
  }
}

// 별점 불러오기
function getStarIcons(rating) {
    var starIcons = '';
    for (var i = 1; i <= 5; i++) {
        if (i <= rating) {
            starIcons += '&#9733;'; // 별 아이콘
        } else {
            starIcons += '&#9734;'; // 빈 별 아이콘
        }
    }
    return starIcons;
}

//후기 등록
function addReview() {
var reviewForm = document.getElementById('reviewForm');
var reviewTextArea = document.getElementById('reviewTextArea');
var newReview = reviewTextArea.value;


// 서버로 보낼 데이터를 객체로 생성
var requestData = {
review: newReview
};

}

//후기 수정 폼 보여주기
function showEditReviewForm(reviewId, data) {
var modalContentArea = document.getElementById('modal');

var editReviewFormHTML = `
<div id="editReviewForm">
  <form id="updateReviewForm" action="/maplist/updatereview.do" method="POST">
  <h3 style="margin-right: 414px;">수정하기<h3>
  <hr style="width: 459px;">
  <textarea id="reviewTextArea" name="restaurantReview" rows="4" cols="50" placeholder="수정할 내용을 입력하세요."></textarea>
  <input type="hidden" name="reviewId" value=`+reviewId+`>
  <button id="updateButton" type="sumbit">수정</button>
  <button id="cancelButton" type="button">취소</button> 
  </form>
</div>
`;

modalContentArea.innerHTML = editReviewFormHTML;

//취소 버튼 클릭 시 이벤트 처리
var cancelButton = document.getElementById('cancelButton');
cancelButton.addEventListener('click', function(event) {
  location.reload() 
  });
}

//후기 삭제 확인 창 보여주기
function showDeleteReviewConfirmation(reviewId) {
var modalContentArea = document.getElementById('modal'); 

var deleteConfirmationHTML = `
<div id="deleteReviewForm">
	<form id="deleteReview" action="/maplist/deletereview.do" method="GET">
	<p style="color:#6E6E6E;"><img src="/resources/image/삭제.png" width="20" height="20"> 후기를 삭제하시겠습니까?</p>
  <input type="hidden" name="reviewId" value=`+reviewId+`>
  <button id="deleteReview" type="sumbit">삭제</button>
  <button id="cancelDeleteButton" type="button">취소</button>   
  </form>
</div>
`;

modalContentArea.innerHTML = deleteConfirmationHTML;

//취소 버튼 클릭 시 이벤트 처리
var cancelDeleteButton = document.getElementById('cancelDeleteButton');
cancelDeleteButton.addEventListener('click', function(event) {
  location.reload() 
  });
}


//리스트 클릭 이벤트 처리
document.getElementById('placesList').addEventListener('click', function (e) {
var target = e.target;
var itemEl = null; 
var clickedItemId = null; // 클릭된 요소의 아이디 가져오기

// 클릭된 요소가 li.item을 찾을 때까지 부모 요소를 탐색
while (target !== this) {
if (target.tagName.toLowerCase() === 'li' && target.classList.contains('item')) {
  itemEl = target;
  clickedItemId = target.id; // 클릭된 요소의 아이디 가져오기
  break;
}
target = target.parentNode;
}

if (itemEl) {
// 클릭한 항목의 인덱스를 가져옵니다.
 var itemIndex = Array.prototype.indexOf.call(this.children, itemEl);

// itemIndex를 사용하여 해당 API 데이터에서 클릭한 데이터 추출
var clickedData = apiData[itemIndex];

// 저장된 데이터 중에서 인덱스가 1인 데이터를 꺼내서 출력
var dataAtIndex1 = apiData[1];

showPlaceInfo(clickedData);

}
});

// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.398781,126.920842), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
  };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var cnt = 0;

var restaurantNames = [];

//API로부터 가져온 데이터를 저장할 글로벌 변수
var apiData = [];

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {
	var keyword = document.getElementById('keyword').value;

	if (!keyword || keyword === "음식 또는 식당명을 입력하세요.") {
        keyword = "안양 맛집";
    }
   
    var options = {
            location: new kakao.maps.LatLng(37.398781,126.920842),
            radius: 2500,
            sort: kakao.maps.services.SortBy.DISTANCE,
            size:7,
          };
    

          // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
          ps.keywordSearch(keyword, placesSearchCB, options);

}

//장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
if (status === kakao.maps.services.Status.OK) {

    // 정상적으로 검색이 완료됐으면
    // 검색 목록과 마커를 표출합니다
    displayPlaces(data);

	// API 데이터를 글로벌 변수에 저장
    apiData = data;

 	// 상호명 데이터를 하나씩 꺼내오기
    data.forEach(function (restaurant) {
    var restaurantName = restaurant.place_name;
    
    // AJAX 요청 수정 : POST 요청으로 리뷰 데이터 요청
    $(document).ready(function (){
    	ajax(restaurantName);
    })
});
    // 페이지 번호를 표출합니다
    displayPagination(pagination);
} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

    alert('검색 결과가 존재하지 않습니다.');
    return;

} else if (status === kakao.maps.services.Status.ERROR) {

    alert('검색 결과 중 오류가 발생했습니다.');
    return;

}
}

function ajax(restaurantName){
restaurantNames.push(restaurantName);
if(cnt === 6) {
   $.ajax({
       type: "POST",
       dataType: "json", // 서버가 JSON 형식으로 응답을 보내길 기대
       contentType: "application/json",
       async: false,
       url: "/maplist/reviews.do", // 서버의 컨트롤러 URL을 입력
       data: JSON.stringify(restaurantNames),
       success: function (response) {
    	   console.log(response);
    	   resultData = response;
    	    /* addStarRatings(response); */  
       },
       error: function (error) {
           // 오류가 발생한 경우, 처리하는 코드 작성
           console.error(error); // 오류 메시지를 출력하거나 오류 처리를 진행
       },
   });
}
cnt++;
}

//검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

var listEl = document.getElementById('placesList'), 
menuEl = document.getElementById('menu_wrap'),
fragment = document.createDocumentFragment(), 
bounds = new kakao.maps.LatLngBounds(), 
listStr = '';

// 검색 결과 목록에 추가된 항목들을 제거합니다
removeAllChildNods(listEl);

// 지도에 표시되고 있는 마커를 제거합니다
removeMarker();

for ( var i=0; i<places.length; i++ ) {

    // 마커를 생성하고 지도에 표시합니다
    var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
        marker = addMarker(placePosition, i), 
        itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    // LatLngBounds 객체에 좌표를 추가합니다
    bounds.extend(placePosition);

    // 마커와 검색결과 항목에 mouseover 했을때
    // 해당 장소에 인포윈도우에 장소명을 표시합니다
    // mouseout 했을 때는 인포윈도우를 닫습니다
    (function(marker, title) {
        kakao.maps.event.addListener(marker, 'mouseover', function() {
            displayInfowindow(marker, title);
        });

        kakao.maps.event.addListener(marker, 'mouseout', function() {
            infowindow.close();
        });

        itemEl.onmouseover =  function () {
            displayInfowindow(marker, title);
        };

        itemEl.onmouseout =  function () {
            infowindow.close();
        };
    })(marker, places[i].place_name);

    fragment.appendChild(itemEl);
}

// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
listEl.appendChild(fragment);

// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
map.setBounds(bounds);
}

//검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

var el = document.createElement('li'),
itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
            '<div class="info" id="getRating">' +
            '   <h5 id="rating_place_name">' + places.place_name + '</h5>';

if (places.road_address_name) {
    itemStr += '    <span>' + places.road_address_name + '</span>';
} else {
    itemStr += '    <span>' +  places.address_name  + '</span>'; 
}
             
  itemStr += '  <span class="tel">' + places.phone  + '</span>' +
            '</div>';           

el.innerHTML = itemStr;
el.className = 'item';

return el;
}

//마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
    imageSize = new kakao.maps.Size(30, 35),  // 마커 이미지의 크기
    imgOptions =  {
        spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
        spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
        offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
    }
     markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
        position: position, // 마커의 위치
        image: markerImage 
    });  

marker.setMap(map); // 지도 위에 마커를 표출합니다
markers.push(marker);  // 배열에 생성된 마커를 추가합니다

return marker;
}

//지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
for ( var i = 0; i < markers.length; i++ ) {
    markers[i].setMap(null);
}   
markers = [];
}

//검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
var paginationEl = document.getElementById('pagination'),
    fragment = document.createDocumentFragment();
  
 // 기존에 추가된 페이지번호를 삭제합니다
removeAllChildNods(paginationEl);

for (i=1; i<=pagination.last; i++) {
    var el = document.createElement('a');
    el.href = "#";
    el.innerHTML = i;

    if (i===pagination.current) {
        el.className = 'on btn-7';
    } else {
        el.onclick = (function(i) {
            return function() {
                pagination.gotoPage(i);
            }
        })(i);
    }

    fragment.appendChild(el);
}
paginationEl.appendChild(fragment);
}

//검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
//인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

infowindow.setContent(content);
infowindow.open(map, marker);
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
while (el.hasChildNodes()) {
    el.removeChild (el.lastChild);
}
}


</script>


</body>
</html>
