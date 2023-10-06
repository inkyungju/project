package kr.co.menupass.map.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.co.menupass.map.dao.MapListDao;
import kr.co.menupass.map.dto.MapList;

@Service
public class MapListServiceImpl implements MapListService {
	
	@Autowired
	private MapListDao maplistDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	 @Override
	    public List<MapList> restaurantReview(String restaurantName) {
		 return maplistDao.restaurantReview(restaurantName);
	      
	}

	 @Override
	    public void addReview(String restaurantName, String reviewText) {
	        maplistDao.addReview(restaurantName, reviewText);
	   
	 }
	 
	@Override
	public int insertReview(MapList mapList) {
		return maplistDao.insertReview(mapList);
	}

	@Override
	public MapList getRestaurantId(String restaurantName) {
		return maplistDao.getRestaurantId(restaurantName);
	}

	@Override
	public MapList getReviewId(int reviewId) {
		return maplistDao.getReviewId(reviewId);
	}

	@Override
	public int updateReview(MapList mapList) {
		return maplistDao.updateReview(mapList);
		
	}
	
	@Override
	public int deleteReview(int reviewId) {
		return maplistDao.deleteReview(reviewId);
	}
	
	@Override
	public int insertImage(MapList mapList) {
		return maplistDao.updateImage(mapList);
	}
	
	@Override
	public List<MapList> restaurantAvgRating(String restaurantName) {
		return maplistDao.restaurantAvgRating(restaurantName);
		
	}

	@Override
	public int reviewInsert(MapList mapList) {
		return maplistDao.reviewInsert(mapList);
	}

}
