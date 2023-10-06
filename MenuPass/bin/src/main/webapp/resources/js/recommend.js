
 $(function(){
    $(".card").slice(0, 8).show(); // 초기갯수
    $("#load").click(function(e){ // 클릭시 more
        e.preventDefault();
        $(".card:hidden").slice(0, 8).show(); // 클릭시 more 갯수 지저정
        if($(".card:hidden").length == 0){ // 컨텐츠 남아있는지 확인
            alert("마지막 페이지 입니다."); // 컨텐츠 없을시 alert 창 띄우기 
        }
    });
});

		
