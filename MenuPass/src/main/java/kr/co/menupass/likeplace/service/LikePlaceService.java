package kr.co.menupass.likeplace.service;

import java.util.List;

import kr.co.menupass.likeplace.dto.LikePlace;

public interface LikePlaceService {

	int addLikedPlace(LikePlace likePlace);
    int removeLikedPlace(LikePlace likePlace);
	boolean isLikedPlace(LikePlace likePlace);
	
	List<LikePlace> getLikedPlacesByUser(LikePlace likePlace);


}
