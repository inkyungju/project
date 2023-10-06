package kr.co.menupass.recommend.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.menupass.common.model.dto.PageInfo;
import kr.co.menupass.recommend.dao.RecommendDao;
import kr.co.menupass.recommend.dto.Recommend;

@Service
public class RecommendServiceImpl implements RecommendService{

    
	@Autowired
	private RecommendDao recommendDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount(String searchTxt) {
		return recommendDao.selectListCount(sqlSession, searchTxt);
	}
	
	 @Override
	 public List<Recommend> selectListAll(PageInfo pi, String searchTxt) {
	    return recommendDao.selectListAll(sqlSession, pi, searchTxt);
	    }

	@Override
	public int insertRecommend(Recommend re) {
		return recommendDao.insertRecommend(sqlSession, re);
	}
	
	@Override
	public Recommend detailRecommend(int board_No) {
		return recommendDao.detailRecommend(sqlSession, board_No);
	}
	@Override
	public int countRecommend(Recommend re) {
		return recommendDao.countRecommend(sqlSession, re);
}
	
	@Override
	public int updateRecommend(Recommend re) {
		return recommendDao.updateRecommend(sqlSession, re);
	}
	
	@Override
	public int updateUploadRecommend(Recommend re) {
		return recommendDao.updateUploadRecommend(sqlSession, re);	
	}
	
	@Override
	public int deleteRecommend(Recommend re) {
		return recommendDao.deleteRecommend(sqlSession, re);
	}
}
