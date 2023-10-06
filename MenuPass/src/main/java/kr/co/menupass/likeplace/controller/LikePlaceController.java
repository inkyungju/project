package kr.co.menupass.likeplace.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.co.menupass.likeplace.dto.LikePlace;
import kr.co.menupass.likeplace.service.LikePlaceService;

@Controller
@RequestMapping("/api")
public class LikePlaceController {

    private final LikePlaceService likePlaceService;

    // 생성자를 통한 의존성 주입
    @Autowired
    public LikePlaceController(LikePlaceService likePlaceService) {
        this.likePlaceService = likePlaceService;
    }

    // 나의 장소 리스트를 보여주는 요청을 처리하는 메서드
    @RequestMapping("/map")
    public String MyPlaceList() {
        return "likeplace/likeplace";
    }

    @PostMapping("/addPlace")
    @ResponseBody
    public String addPlace(LikePlace likePlace,
                           HttpSession session
                           ) {
        
        likePlace.setMemberNo((int)session.getAttribute("memberNo"));
        
        boolean isLiked = likePlaceService.isLikedPlace(likePlace);
        
        int result = 0;

        if (isLiked) {
        	System.out.println("remove");
            result = likePlaceService.removeLikedPlace(likePlace);
        } else {
        	System.out.println("add");
            result = likePlaceService.addLikedPlace(likePlace);
        }

        if (result > 0) {
            return "success";
        } else {
            return "cancel";
        }
    }
  //찜하기 가져오기
    @PostMapping("/select")
    public ResponseEntity<List<LikePlace>> checkLikedPlacesByUser(@RequestBody List<LikePlace> data,
    															  HttpSession session) {

    	LikePlace likePlace = new LikePlace();
    	
    	for(LikePlace item : data) {
    		if(item.getKeyword() != null && item.getKeyword().equals("전체")) {
    			likePlace.setKeyword("");
    		} else if (item.getKeyword() != null) {
    			likePlace.setKeyword(item.getKeyword());
    		}
    	}
    	

    	likePlace.setMemberNo((int)session.getAttribute("memberNo"));
    	
        List<LikePlace> likedPlaces = likePlaceService.getLikedPlacesByUser(likePlace);
     

        // 변경된 likedPlaces를 반환합니다.
        return new ResponseEntity<>(likedPlaces, HttpStatus.OK);
    }
        

}


