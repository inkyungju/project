<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>LikePlacePass</title>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
   crossorigin="anonymous">
   <link href="../../resources/css/mainMenu.css" rel="stylesheet">
<style>
#placesList {
   color: #212529;
}

.map_wrap, .map_wrap * {
   margin: 0;
   padding: 0;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
   color: white;
   text-decoration: none;
}
/* .map_wrap {position:relative;width:100%;height:500px;} */
.map_wrap {
   position: relative;
   width: 100%;
}

#menu_wrap {
   position: absolute;
   top: 0;
   bottom: 0;
   width: 285px;
   margin: 0px 15px 0px 20px;
   overflow-y: auto;
   background: white;
   z-index: 1;
   font-size: 12px;
}

.bg_white {
   background: #fff;
}

#menu_wrap hr {
   display: block;
   height: 1px; : 0;
   border-top: 2px solid #5F5F5F;
   margin: 3px 0;
}

#menu_wrap .option {
   text-align: center;
}

#menu_wrap .option p {
   margin: 10px 0;
}

#menu_wrap .option button {
   margin-left: 5px;
}

#placesList li {
   list-style: none;
}

#placesList .item {
   position: relative;
   border-bottom: 1px solid #888;
   overflow: hidden;
   cursor: pointer;
   min-height: 65px;
}

#placesList .item span {
   display: block;
   margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}

#placesList .item .info {
   padding: 10px 0 10px 30px;
}

#placesList .info .gray {
   color: #8a8a8a;
}

#placesList .info .jibun {
   padding-left: 26px;
   background:
      url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
      no-repeat;
}

#placesList .info .tel {
   color: #009900;
}

/* #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;} */
/* #placesList .item .marker_1 {background-position: 0 -10px;} */
/* #placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}   */
#pagination {
   margin: 10px auto;
   text-align: center;
}

#pagination a {
   display: inline-block;
   margin-right: 10px;
}

#pagination .on {
   font-weight: bold;
   cursor: default;
   color: #777;
}

.btn.btn-outline-danger.active {
   background-color: white; /* 배경 색상을 흰색으로 설정 */
   color: red; /* 글씨 색상을 빨간색으로 설정 */
   border-color: #888888; /* 테두리 색상을 검정색으로 설정 */
   border-style: solid; /* 테두리 스타일을 실선으로 설정 */
}

.btn.btn-outline-danger {
   margin-top: 5px;
}

#map {
	left: 10%;
    width: 64%;
   border: 1px solid white; /* 원하는 테두리 스타일과 색상 지정 */
}

#header {
   width: 60%;
   left: 12%;
   position: inherit;
   text-align: center;
   margin-bottom: 20px;
   width: 50%;
   padding: 10px;
   background-color: rgb(138 176 188/ 17%);
   font-size: 24px;
   border: 1px solid white; /* 원하는 테두리 스타일과 색상 지정 */
   margin-bottom: 5px;
}

.menubtn {
   padding: 10px;
   border: none;
   margin: 0;
}

.help{
	margin-left: 118px;
	color: #414581;
}
hr{
    width: 87%;
    margin: 10px;
    padding:0;
    color: #414581;
}

.btn-outline-danger:hover{
	background-color: #dc35455c;
	color: #fff;
    border-color: #dc3545;
}

</style>

<%-- <%@ include file="../common/head.jsp"%> --%>

</head>
<body>
   <div id="mainMenu">
      <%@ include file="../common/mainMenu.jsp"%>
   </div>
   <%@ include file="../common/minigame.jsp"%>

<div class="help">LikePlace Pass</div>
				<hr style="margin-left: 114px;">
   <div class="map_wrap">
      <!-- "마이플레이스" 헤더 부분 -->

      <div style="position: relative;" class="container">
         <div id="menu_wrap " class="bg_white col-md-8"
            style="position: absolute; top: 0px; right: 10px; overflow-y: auto; width: 280px; height: 570px; background: rgb(245 195 158 / 19%); z-index: 100; font-size: 12px;">
            <div class="option">

               <div>

                  <div id="button_group" class="container-fluid">
                     <div class="row">
                        <div class="col-6">
                           <button type="submit" id="bt1"
                              class="menubtn m-0 w-100 border-end"
                              onclick="location.href='/api/map'; tgl1();">검색하기</button>
                        </div>
                        <div class="col-6">
                           <button type="submit" id="bt2" class="menubtn m-0 w-100"
                              style="background-color: rgb(251 239 230);"
                              onclick="location.href='/api/map?status=like'; tgl2();">찜목록</button>
                        </div>
                     </div>
                  </div>


                  <br>
                  <form onsubmit="searchPlaces(); return false;" style="margin-left:28px">
                     키워드 : <input type="text" value="전체" id="keyword" size="15">
                     <button type="submit">검색하기</button>
                     <br>
                  </form>
               </div>
            </div>
            <hr>
            <ul id="placesList"></ul>
            <div id="pagination"></div>
         </div>


         <div id="map" style="height: 570px;" class="col-md-4"></div>
      </div>

   </div>
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
      crossorigin="anonymous"></script>

   <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=?=services"></script>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script src="../resources/js/likeplace.js"></script>
</body>
</html>
