package kr.co.menupass.map.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString

public class MapList {
	private int restaurantId; // 식당아이디
	private int memberNo; // 회원 아이디
	private String memberName; // 회원 이름
	private int reviewId; // 리뷰 아이디
	private String restaurantName; // 식당상호명
	private String restaurantNames; // 식당상호명1
	private String restaurantAddress; // 식당주소
	private String restaurantPhone; // 식당전화번호
	private String restaurantCuisine; // 음식종류
	private String restaurantHours; // 식당 영업시간
	private String restaurantReview; // 식당 리뷰
	private int restaurantRating; // 식당 별점
	private int restaurantAvgRating; // 식당 평균 별점
	private String restaurantCreateDate; // 후기 작성시간
	
	private String uploadPath;
	private String uploadName;
	private String uploadOriginName;

}
