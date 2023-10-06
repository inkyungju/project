package kr.co.menupass.recommend.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.menupass.common.model.dto.PageInfo;
import kr.co.menupass.recommend.dto.Recommend;

@Repository
public class RecommendDao {

	public int selectListCount(SqlSessionTemplate sqlSession, String searchTxt) {
		return sqlSession.selectOne("recommendMapper.selectListCount");
	}

	public List<Recommend> selectListAll(SqlSessionTemplate sqlSession, PageInfo pi, String searchTxt) {
		return sqlSession.selectList("recommendMapper.selectListAll", pi);
	}

	public int insertRecommend(SqlSessionTemplate sqlSession, Recommend re) {
		System.out.println(re.getMemberNo());
		return sqlSession.insert("recommendMapper.insertRecommend", re);
	}

	public Recommend detailRecommend(SqlSessionTemplate sqlSession, int member_No) {
		return sqlSession.selectOne("recommendMapper.detailRecommend", member_No);
	}

	public int countRecommend(SqlSessionTemplate sqlSession, Recommend re) {
		return sqlSession.update("recommendMapper.countRecommend", re);
	}

	public int updateRecommend(SqlSessionTemplate sqlSession, Recommend re) {
		return sqlSession.update("recommendMapper.updateRecommend", re);
	}

	public int deleteRecommend(SqlSessionTemplate sqlSession, Recommend re) {
		return sqlSession.delete("recommendMapper.deleteRecommend", re);
	}

	public int updateUploadRecommend(SqlSessionTemplate sqlSession, Recommend re) {
		return sqlSession.update("recommendMapper.updateUploadRecommend", re);
	}
}
