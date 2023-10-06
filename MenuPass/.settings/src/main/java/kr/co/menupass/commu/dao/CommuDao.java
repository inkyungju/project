package kr.co.menupass.commu.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.menupass.common.model.dto.PageInfo2;
import kr.co.menupass.commu.dto.Commu;

@Repository
public class CommuDao {

	public int selectListCount(SqlSessionTemplate sqlSession, String searchTxt) {
		return sqlSession.selectOne("commuMapper.selectListCount", searchTxt);
	}
	
	public List<Commu> selectListAll(SqlSessionTemplate sqlSession, PageInfo2 pi, String searchTxt) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return sqlSession.selectList("commuMapper.selectListAll", searchTxt, rowBounds);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, Commu co) {
		return sqlSession.insert("commuMapper.insertBoard", co);
	}
	
	public Commu detailBoard(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectOne("commuMapper.detailBoard", idx);
	}

	public int countBoard(SqlSessionTemplate sqlSession, Commu co) {
		return sqlSession.update("commuMapper.countBoard", co);
	}
	
	public int updateBoard(SqlSessionTemplate sqlSession, Commu co) {
		return sqlSession.update("commuMapper.updateBoard", co);
	}
	
	public int deleteBoard(SqlSessionTemplate sqlSession, Commu co) {
		return sqlSession.delete("commuMapper.deleteBoard", co);
	}

	public int updateUploadFree(SqlSessionTemplate sqlSession, Commu co) {
		return sqlSession.update("commuMapper.updateUploadFree", co);
	}
}






