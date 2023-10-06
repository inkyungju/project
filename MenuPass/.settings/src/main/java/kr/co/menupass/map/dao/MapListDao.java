package kr.co.menupass.map.dao;


import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.menupass.map.dto.MapList;



@Repository
public class MapListDao {

	    private SqlSession sqlSession;

		@Autowired
	    public MapListDao(SqlSession sqlSession) {
	        this.sqlSession = sqlSession;
	    }
		
		// 식당 리뷰
		public List<MapList> restaurantReview(String restaurantName) {
			return sqlSession.selectList("mapListMapper.reviewsByRestaurantName",restaurantName);
		        
		}

		public void addReview(String restaurantName, String reviewText) {
			
		}
		
		public int insertReview(MapList mapList) {
			return sqlSession.insert("mapListMapper.insertReview", mapList);
		}

		public MapList getRestaurantId(String restaurantName) {
			return sqlSession.selectOne("mapListMapper.getRestaurantId", restaurantName);
		}

		public MapList getReviewId(int reviewId) {
		    return sqlSession.selectOne("mapListMapper.getReviewId", reviewId);
		}

		public int updateReview(MapList mapList) {
			return sqlSession.update("mapListMapper.updateReview", mapList);
		}

		public int deleteReview(int reviewId) {
			return sqlSession.delete("mapListMapper.deleteReview", reviewId);
		}
		
		public int updateImage(MapList mapList) {
			return sqlSession.update("mapListMapper.updateImage", mapList);
		}

		public List<MapList> restaurantAvgRating(String restaurantName) {
			return sqlSession.selectList("mapListMapper.restaurantAvgRating", restaurantName);
		}
		
		public int reviewInsert(MapList mapList) {
			return sqlSession.insert("mapListMapper.reviewInsert", mapList);
		}
}   
