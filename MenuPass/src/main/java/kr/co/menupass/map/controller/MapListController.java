package kr.co.menupass.map.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.menupass.common.model.dto.PageInfo;
import kr.co.menupass.map.dto.MapList;
import kr.co.menupass.map.service.MapListServiceImpl;
import kr.co.menupass.recommend.dto.Recommend;
import kr.co.menupass.recommend.service.RecommendService;

@Controller
@RequestMapping("/maplist")
public class MapListController<ReviewText> {
	
	@Autowired
	MapListServiceImpl maplistService;
	
	 @Autowired
	RecommendService recommendService;


	@RequestMapping("/list.do")
	public String mapList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
						   Model model, HttpSession session) {
		
		model.addAttribute("msg", (String) session.getAttribute("msg"));
    	model.addAttribute("status", (String) session.getAttribute("status"));
    	
    	session.removeAttribute("msg");
    	session.removeAttribute("status");
    	
    	
    	List<Recommend> list = recommendService.selectListAll(null, null);
    	
    	model.addAttribute("list", list);
    	 
    	
		return "maplist/maplist"; // JSP 페이지 이름 반환
		   
	}
	
	@PostMapping("/addreview.do") // 상호명으로 식당 아이디 가져오기
	public String addReview(MultipartFile reviewImage, MapList mapList, 
							HttpSession session) {
		mapList.setMemberNo((int) session.getAttribute("memberNo"));
		mapList.setMemberName((String) session.getAttribute("memberName"));
		
		System.out.println((String) session.getAttribute("memberName"));
		
		MapList restaurantId = maplistService.getRestaurantId(mapList.getRestaurantName());
		//reviewinsert = 레스토랑 등록
		//insertreview = 레스토랑 리뷰 등록
			if (Objects.isNull(restaurantId)) {
			
	        int restaurantReview = maplistService.reviewInsert(mapList);
	        
	        restaurantId = maplistService.getRestaurantId(mapList.getRestaurantName());
	       
	    }
		
        try {
        	
			UploadFileController3.uploadFile(reviewImage, mapList);
			
		} catch (IllegalStateException | IOException e) {
			
			e.printStackTrace();
		}
        
        mapList.setRestaurantId(restaurantId.getRestaurantId());
        
        int result = maplistService.insertReview(mapList);
		
		if(result > 0) {
			session.setAttribute("msg", "후기작성에 성공하였습니다");
			session.setAttribute("status", "success");
			return "redirect:/maplist/list.do";
			
		} else {
			session.setAttribute("msg", "후기작성을 실패하였습니다");
			session.setAttribute("status", "error");
			return "common/error";
		}
	    
	}
	
    @PostMapping("/updatereview.do") // 수정하기
    public String updateReview(MapList mapList, HttpSession session) {
       
        int result = maplistService.updateReview(mapList);

        if (result > 0) {
        	session.setAttribute("msg", "수정되었습니다");
			session.setAttribute("status", "success");
            return "redirect:/maplist/list.do"; 
            
        } else {
        	session.setAttribute("msg", "수정을 실패했습니다");
			session.setAttribute("status", "error");
            return "common/error";
        }
    }
    
    @GetMapping("/deletereview.do") // 삭제하기
    public String deleteReview(@RequestParam int reviewId, 
    							HttpSession session) {
        int result = maplistService.deleteReview(reviewId);

        if (result > 0) {
        	session.setAttribute("msg", "삭제되었습니다");
			session.setAttribute("status", "success");
            return "redirect:/maplist/list.do"; 
            
        } else {
        	session.setAttribute("msg", "삭제를 실패했습니다");
			session.setAttribute("status", "error");
            return "common/error";
        }
    }
	
	@PostMapping("/reviews.do") // 식당 리뷰
	@ResponseBody
	public List<MapList> reviewsByRestaurantName(@RequestBody String[] restaurantNames) {
		List<MapList> result = new ArrayList<>();
		new ArrayList<>();
	
		
	//	// 리뷰 정보 result에 담는 코드
		for (String restaurantName : restaurantNames) {
			List<MapList> reviews = maplistService.restaurantReview(restaurantName);
			result.addAll(reviews);
		}
		
		for(MapList item : result) {
			System.out.println(item.toString());
		}
	    return result; 
	}
		
	@PostMapping("/rating.do")
	@ResponseBody
	public int restaurantAvgRating(String restaurantName) {
		List<MapList> rating = maplistService.restaurantAvgRating(restaurantName);
		
		int sum = 0;
		
		for(MapList item : rating) {
			sum+= item.getRestaurantRating();
		}
		
		int avg = sum / rating.size();
		
		return avg;
	}
	
}