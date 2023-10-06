<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>날씨 정보</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div id="weather">
    <!-- 첫 번째 날씨 정보 카드 -->
    <div class="weather-card">
        <h1></h1>
        <p><span id="temperature1"></span>°C</p> <!--온도 -->
        <p><img id="weather-icon1" src="" alt="날씨 아이콘" style="width: 80px;"></p> <!--아이콘-->
        <p><span id="city1"></span></p> <!--도시이름-->
        
    </div>

    <!-- 두 번째 날씨 정보 카드 -->
    <div class="weather-card">
        <h1></h1>
        <p><span id="temperature2"></span>°C</p> <!--온도 -->
        <p><img id="weather-icon2" src="" alt="날씨 아이콘" style="width: 80px;"></p> <!--아이콘-->
        <p><span id="city2"></span></p> <!--도시이름-->
        
    </div>

    <!-- 세 번째 날씨 정보 카드 (대전) -->
    <div class="weather-card">
        <h1></h1>
        <p><span id="temperature3"></span>°C</p> <!--온도 -->
        <p><img id="weather-icon3" src="" alt="날씨 아이콘" style="width: 80px;"></p> <!--아이콘-->
        <p><span id="city3"></span></p> <!--도시이름-->
      
    </div>

    <!-- 네 번째 날씨 정보 카드 (제주도) -->
    <div class="weather-card">
        <h1></h1>
        <p><span id="temperature4"></span>°C</p> <!--온도 -->
        <p><img id="weather-icon4" src="" alt="날씨 아이콘" style="width: 80px;"></p> <!--아이콘-->
        <p><span id="city4"></span></p> <!--도시이름-->
        
    </div>
    
    <!-- 다섯번째 미니게임 탭 -->
    <div class="weather-card1">
      <div>추천메뉴</div>
      <div class="slider1 hidden" id="slider1">
         <div class="menu-container">
            <button class="menu-button" onclick="recommendFood('allRandom')">Start</button>
         </div>
         <div class="menu-result" id="recommendation"></div>
      </div>
   </div>
</div>
    <script>
    $(document).ready(function() {
        // 첫 번째 도시 정보
        var apiURI1 = "http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=e55b526bfe7e3fe73aaa86f61bb4aa4e";
        $.ajax({
            url: apiURI1,
            dataType: "json",
            type: "GET",
            async: "false",
            success: function(resp) {
                $("#city1").text(resp.name);
                $("#temperature1").text((resp.main.temp - 273.15).toFixed(1));
                $("#description1").text(resp.weather[0].description);
                var iconUrl1 = "http://openweathermap.org/img/wn/" + resp.weather[0].icon + ".png";
                $("#weather-icon1").attr("src", iconUrl1);
            }
        });

        // 두 번째 도시 정보
        var apiURI2 = "http://api.openweathermap.org/data/2.5/weather?q=Daejeon&appid=e55b526bfe7e3fe73aaa86f61bb4aa4e";
        $.ajax({
            url: apiURI2,
            dataType: "json",
            type: "GET",
            async: "false",
            success: function(resp) {
                $("#city2").text(resp.name);
                $("#temperature2").text((resp.main.temp - 273.15).toFixed(1));
                $("#description2").text(resp.weather[0].description);
                var iconUrl2 = "http://openweathermap.org/img/wn/" + resp.weather[0].icon + ".png?" + new Date().getTime(); // 난수 추가
                $("#weather-icon2").attr("src", iconUrl2);
            }
        });

        // 세 번째 도시 정보 (대전)
        var apiURI3 = "http://api.openweathermap.org/data/2.5/weather?q=Busan&appid=e55b526bfe7e3fe73aaa86f61bb4aa4e";
        $.ajax({
            url: apiURI3,
            dataType: "json",
            type: "GET",
            async: "false",
            success: function(resp) {
                $("#city3").text(resp.name);
                $("#temperature3").text((resp.main.temp - 273.15).toFixed(1));
                $("#description3").text(resp.weather[0].description);
                var iconUrl3 = "http://openweathermap.org/img/wn/" + resp.weather[0].icon + ".png?" + new Date().getTime();
                $("#weather-icon3").attr("src", iconUrl3);
            }
        });

        // 네 번째 도시 정보 (제주도)
        var apiURI4 = "http://api.openweathermap.org/data/2.5/weather?q=Jeju&appid=e55b526bfe7e3fe73aaa86f61bb4aa4e";
        $.ajax({
            url: apiURI4,
            dataType: "json",
            type: "GET",
            async: "false",
            success: function(resp) {
                $("#city4").text(resp.name);
                $("#temperature4").text((resp.main.temp - 273.15).toFixed(1));
                $("#description4").text(resp.weather[0].description);
                var iconUrl4 = "http://openweathermap.org/img/wn/" + resp.weather[0].icon + ".png?" + new Date().getTime();
                $("#weather-icon4").attr("src", iconUrl4);
            }
        });
    });

    
    function getRandomFood(foodList) {
        return foodList[Math.floor(Math.random() * foodList.length)];
     }
     function recommendFood(category) {
        var foodList = {
           allRandom : [ '가츠동', '간장게장', '간장계란밥', '간장치킨', '간짜장', '갈비',
                 '갈비찜', '갈비탕', '감동란', '감바스', '감자국', '감자탕', '게국지', '계란국',
                 '고로케', '고르곤졸라', '고추잡채밥', '고추장불고기', '고추장찌개', '고추짜장',
                 '골뱅이무침', '곰치국', '곰탕', '굴국밥', '규동', '규카츠덮밥', '근대된장국',
                 '김밥', '김치볶음밥', '김치제육덮밥', '김치찌개', '깐쇼새우', '깐풍기', '꼬치어묵',
                 '낙지볶음', '낙지호롱이', '날치알덮밥', '낫또', '내장탕', '냉모밀', '냉이된장국',
                 '누룽지', '닭갈비', '닭강정', '닭개장', '닭곰탕', '닭꼬치', '닭발', '닭백숙',
                 '닭볶음탕', '닭죽', '대구매운탕', '대구뽈랑', '대구지리탕', '대파라면',
                 '대패삼겹살', '도가니탕', '돈가스', '돈부리', '돈카츠', '돌솥비빔밥', '동태찌개',
                 '동파육', '돼지주물럭', '된장국', '된장찌개', '등갈비묵은지김치찜', '등뼈찜',
                 '떡갈비정식', '떡국', '떡만둣국', '떡볶이', '또띠아', '똥집', '라멘', '라볶이',
                 '루꼴라피자', '리조또', '마늘치킨', '마라탕', '마카롱', '마파두부밥', '막국수',
                 '만두', '만둣국', '매생이국', '맥반석계란', '메기매운탕', '메밀소바', '목살',
                 '몬테크리스토', '물냉면', '물회', '미소된장국', '바질파스타', '밥버거',
                 '배추된장국', '보쌈', '복지리탕', '봉골레', '부대찌개', '북엇국', '분짜',
                 '불고기덮밥', '불고기피자', '불곱창', '비빔국수', '비빔냉면', '비빔밥', '비지찌개',
                 '빠네파스타', '뼈해장국', '사천탕수육', '삼겹살', '삼겹김치말이찜', '삼계탕',
                 '새우볶음밥', '새우장', '샌드위치', '샐러드', '생선가스', '생선구이', '샤브샤브',
                 '선지해장국', '설렁탕', '소고기무국', '소고기미역국', '소바', '쇠고기죽', '수육',
                 '수제비', '순대국', '순대볶음', '순두부찌개', '스크램블에그', '스테이크',
                 '스팸무스비', '스팸볶음밥', '시금치된장국', '시래기국', '시리얼', '시저샐러드',
                 '쌀국수', '쌈밥', '쏘야볶음', '아구찜', '아구탕', '아욱된장국', '알곤이탕',
                 '알리오올리오', '애호박된장국', '야끼니꾸', '야끼소바', '야채볶음밥', '야채죽',
                 '야키니쿠', '약과', '양꼬치', '양념게장', '양념치킨', '양장피', '연어덮밥',
                 '연포탕', '열무국수', '옛날통닭', '오니기리', '오리백숙', '오리불고기', '오리훈제',
                 '오므라이스', '오믈렛', '오삼불고기', '오이냉국', '오징어덮밥', '오징어두루치기',
                 '오징어찌개', '오코노미야끼', '올갱이국', '와플', '우거지국', '우동', '우럭매운탕',
                 '우렁강된장비빔밥', '월남쌈', '유린기', '유부초밥', '육개장', '육회', '육회비빔밥',
                 '일본식카레', '잔치국수', '잡채', '장어구이', '장어덮밥', '전기통닭', '제육덮밥',
                 '제첩국', '족발', '짜글이', '짜장면', '짬뽕', '짱뚱어탕', '쫄면', '찜닭',
                 '참치마요덮밥', '참치죽', '참치회덮밥', '찹스테이크', '찹쌀탕수육', '청국장',
                 '초밥', '추어탕', '치즈피자', '치즈함박스테이크', '치킨마요덮밥', '카레',
                 '카레우동', '칼국수', '칼제비', '캘리포니아롤', '케밥', '코다리조림',
                 '콤비네이션피자', '콩국수', '콩나물국', '콩나물국밥', '크로와상', '크로플',
                 '크룽지', '크림새우', '크림스파게티', '크림우동', '타코', '타코야끼', '탕수육',
                 '텐동', '토마토스파게티', '토마토오븐스파게티', '토스트', '튀김', '파니니', '파닭',
                 '파르페', '파스타', '팔보채', '팟타이', '팬케이크', '페퍼로니피자', '편의점도시락',
                 '프렌치토스트', '피자', '한우', '함박스테이크', '핫도그', '항정살', '해물누룽지탕',
                 '햄버거', '호떡', '호박죽', '홍합탕', '회', '후라이드치킨' ]
        };

        var recommendation = getRandomFood(foodList[category]);
        
        var recommendationElement = document
        .getElementById('recommendation');
 		recommendationElement.textContent = recommendation;
}
    </script>
</body>
</html>