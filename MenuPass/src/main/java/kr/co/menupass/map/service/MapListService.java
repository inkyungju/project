package kr.co.menupass.map.service;

import java.util.List;

import kr.co.menupass.map.dto.MapList;

public interface MapListService {

	// 리뷰
	List<MapList> restaurantReview(String restaurantName);
	
	// 후기쓰기
	void addReview(String restaurantName, String reviewText);
	
	// 후기
	int insertReview(MapList mapList);
	
	// 레스토랑 아이디 
	MapList getRestaurantId(String restaurantName);
	
	// 기존 리뷰 가지고 오기
	MapList getReviewId(int reviewId);

	// 수정하기
	int updateReview(MapList mapList);
	
	// 삭제하기
	int deleteReview(int reviewId);

	// 이미지 업로드
	int insertImage(MapList mapList);
	
	// 별점
	List<MapList> restaurantAvgRating(String restaurantName);
	
	// 리뷰 불러오기
	int reviewInsert(MapList mapList);
	
}
