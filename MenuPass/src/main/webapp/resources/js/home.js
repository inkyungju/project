// 마커를 담을 배열입니다
var markers = [];
var markerChk = [];
var keyword = "";

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		minLevel: 2, // 지도 최저 레벨 값 설정
		maxLevel: 13, // 지도 최대 레벨 값 설정
		level: 3 // 지도의 기본 레벨 값 설정
	};


// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);



// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();


// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

//쿼리 스트링 받기
var oParams = getUrlParams();

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

	keyword = document.getElementById('keyword').value;

	if (!keyword.replace(/^\s+|\s+$/g, '')) {
		alert('키워드를 입력해주세요!');
		return false;
	}

	// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	ps.keywordSearch(keyword, placesSearchCB);
}


// data(카카오에 요청한 data), status(요청 성공여부->카카오전달), pagination(페이징)
function placesSearchCB(data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {
		var resData = null;  // 첫 번째 선언
		data[0].keyword = keyword; //찜목록 검색

		$.ajax({
			type: "POST",
			url: "/api/select",
			contentType: "application/json",
			data: JSON.stringify(data),
			async: false,
			success: function(response) {
				resData = response;  // 기존 변수에 할당 (중복 선언 제거)

			},
			error: function(error) {
				console.log("요청이 실패하였습니다.", error);
			}
		});


		// 정상적으로 검색이 완료됐으면
		// 검색 목록과 마커를 표출합니다
		displayPlaces(data, resData);

		// 페이지 번호를 표출합니다
		displayPagination(pagination);


		$(document).ready(function() {
			btnLike(resData);
		});
	} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		alert('검색 결과가 존재하지 않습니다.');
		return;
	} else if (status === kakao.maps.services.Status.ERROR) {
		alert('검색 결과 중 오류가 발생했습니다.');
		return;
	}
}

//쿼리스트링 가져오기
function getUrlParams() {     
    var params = {};  
    
    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, 
       function(str, key, value) { 
           params[key] = value; 
        }
    );     
    
    return params; 
}

//찜버튼 누르기
function btnLike(resData) {

	// 일치하는 장소 목록을 기반으로 찜하기 버튼 스타일 변경
	resData.forEach(function(places) {
		var button = document.getElementById(places.place_name);
		if (button) {
			button.classList.add('active');
		}
	});
}

//검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places, resData) {
	var listEl = document.getElementById('placesList'),
		menuEl = document.getElementById('menu_wrap'),
		fragment = document.createDocumentFragment(),
		bounds = new kakao.maps.LatLngBounds();
	// 검색 결과 목록에 추가된 항목들을 제거합니다
	removeAllChildNods(listEl);
	

	// 지도에 표시되고 있는 마커를 제거합니다
	// removeMarker();

	if(oParams.status === "like" && resData.length > 0) {
		likeData = resData;
	} else if (oParams.status === "like" && resData.length === 0){
		likeData = "none";
	} else {
		likeData = places;
	}
	
		for (var i = 0; i < likeData.length; i++) {
			if (resData[i] !== undefined) {
				// 마커를 생성하고 지도에 표시합니다
				var placePosition = new kakao.maps.LatLng(resData[i].y, resData[i].x),
					marker = addMarker(placePosition, resData[i].place_name);
					if(oParams.status === "like" && resData.length != 0 && i < resData.length) {

						itemEl = getListItem(i, resData[i]); // 검색 결과 항목 Element를 생성합니다
					} else {

						itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
					}
			} else {
				// 마커를 생성하고 지도에 표시합니다
				if(oParams.status === "like" && resData.length != 0 &&  i < resData.length ) {

					itemEl = getListItem(i, resData[i]); // 검색 결과 항목 Element를 생성합니다
				} else if(oParams.status !== "like"){

					itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
				}
			}
	
			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다''
			if (resData.length === 0) {
				var placePosition = new kakao.maps.LatLng(37.566826, 126.9786567);
				bounds.extend(placePosition);
			} else {
				bounds.extend(placePosition);
			}
			
			//resData(찜누른데이터), 아무거나 입력했을때 해당 데이터 없으면 검색리스트 없음
				mouseOverOut(null, null, null, resData[i]);
				fragment.appendChild(itemEl);
	}
	

	// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	listEl.appendChild(fragment);
	menuEl.scrollTop = 0;

	// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	map.setBounds(bounds);
}


//marker 이벤트 주기 (인포윈도우)
function mouseOverOut(place_name, x, y, resData) {
	if(place_name !== null && x !== null && y !== null) {
		var placePosition = new kakao.maps.LatLng(y, x),
		marker = addMarker(placePosition, place_name);
		(function(marker, title) {
			kakao.maps.event.addListener(marker, 'mouseover', function() {
				displayInfowindow(marker, title);
			});

			kakao.maps.event.addListener(marker, 'mouseout', function() {
				infowindow.close();
			});
		})(marker, place_name);
	} else if (resData !== undefined){
		var placePosition = new kakao.maps.LatLng(resData.y, resData.x),
		marker = addMarker(placePosition,resData.place_name);
		(function(marker, title) {
			kakao.maps.event.addListener(marker, 'mouseover', function() {
				displayInfowindow(marker, title);
			});

			kakao.maps.event.addListener(marker, 'mouseout', function() {
				infowindow.close();
			});
		})(marker, resData.place_name);
	}
} 

//검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

	var el = document.createElement('li'),

		itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
			'<div class="info">' +
			'   <h5>' + places.place_name + '</h5>';
			
	if (typeof places.road_address_name == "undefined" || places.road_address_name == "undefined" ) {
			itemStr += '    <span>' + places.address_name + '</span>';
	} else {
			itemStr += '    <span>' + places.road_address_name + '</span>' +
			'   <span class="jibun gray">' + places.address_name + '</span>';
	}
	
	if (typeof places.phone == "undefined" || places.phone == "undefined") {
		itemStr += '  <span class="tel"> </span>';
	} else {
		itemStr += '  <span class="tel">' + places.phone + '</span>';
	}
	

	itemStr += 		'<input type="button" id=\'' + places.place_name + '\'class="btn btn-outline-danger" value="찜하기❤" onclick="addPlace(' + (index + 1) + ', \'' + places.place_name + '\', \'' + places.address_name + '\', \''  +places.road_address_name + '\', \'' +places.phone + '\', \'' + places.x + '\', \'' + places.y + '\')">'


	'</div>';

	el.innerHTML = itemStr;
	el.className = 'item';



	return el;
}







// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
/*function addMarker(position, idx, title) {


	var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		imageSize = new kakao.maps.Size(24, 35),  // 마커 이미지의 크기
		imgOptions = {
			spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		},

		//기본 마커 이미지
	//	markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,imgOptions),
		markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
		//마커생성
		marker = new kakao.maps.Marker({
			position: position, // 마커의 위치
			image: markerImage
		});

	marker.setMap(map); // 지도 위에 마커를 표출합니다
	markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	return marker;
}*/
// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, title) {
	var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
		imageSize = new kakao.maps.Size(24, 35),
	
		markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
		marker = new kakao.maps.Marker({
			position: position,
			image: markerImage
		});

	// 마커 클릭 이벤트를 추가합니다
	kakao.maps.event.addListener(marker, 'click', function() {
		// 해당 위치로 지도를 이동하면서 주변으로 줌 인합니다
		map.setLevel(3, { anchor: position });
		map.panTo(position);


		// 인포윈도우를 닫은 후 다시 열어줍니다
		infowindow.close();
		displayInfowindow(marker, places.place_name);
	});

	//마커생성
	marker.setMap(map);
	//makers 라는 배열에 marker 정보 넣기
	markers.push(marker);
	//markerChk 라는 배열에 상호명 넣기 
	markerChk.push(title);
	return marker;
}



// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
	var paginationEl = document.getElementById('pagination'),
		fragment = document.createDocumentFragment(),
		i;
		
	// 기존에 추가된 페이지번호를 삭제합니다
	while (paginationEl.hasChildNodes()) {
		paginationEl.removeChild(paginationEl.lastChild);
	}

	if(oParams.status !== "like") {
		for (i = 1; i <= pagination.last; i++) {
			var el = document.createElement('a');
			el.href = "#";
			el.innerHTML = i;
	
	
			if (i === pagination.current) {
				el.className = 'on';
			} else {
				el.onclick = (function(i) {
					return function() {
						pagination.gotoPage(i);
					}
				})(i);
			}
	
			fragment.appendChild(el);
		}
	}
	paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
	var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	infowindow.setContent(content);
	infowindow.open(map, marker);
}


// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {
	while (el.hasChildNodes()) {
		el.removeChild(el.lastChild);
	}
}

//ajax 컨트롤러 요청
//찜하기버튼 처음 눌렀을떄 실행되는 함수 
function addPlace(index, name, address, roadadress, phone, x, y) {
	$.ajax({
		type: "POST",
		url: `/api/addPlace`,
		data: {
			index: index,
			place_name: name,
			address_name: address,
			road_address_name: roadadress, 
			phone: phone,
			x: x,
			y: y
		},
		success: function(response) {
			// 추가로 처리할 작업을 여기에 작성합니다.
			// 찜 버튼을 빨간색으로 변경하거나 원래 스타일로 돌아갑니다.
			var button = document.querySelector('.item:nth-child(' + index + ') .btn');
			if (button) {
				
				//마커제거
				if (button.classList.contains('active')) {
					for(var idx=0; idx<markers.length; idx++) {
						if(name == markerChk[idx]) {
							markers[idx].setMap(null);
							//줌 out
							var placePosition = new kakao.maps.LatLng(y, x);
							map.setLevel(8, { anchor: placePosition });
							map.panTo(placePosition);
						}
					}
					button.classList.remove('active');
					
					//마커찍기
				} else {
					var placePosition = new kakao.maps.LatLng(y, x)
					marker = addMarker(placePosition, name);
					map.setLevel(3, { anchor: placePosition });
					map.panTo(placePosition);
					mouseOverOut(name, x, y, null);
					button.classList.add('active');
				} 
			}
		},
		error: function(error) {
			console.log("찜하기 요청이 실패하였습니다.", error);
			// 요청이 실패하였을 때 처리할 작업을 여기에 작성합니다.
		}
	});
}



