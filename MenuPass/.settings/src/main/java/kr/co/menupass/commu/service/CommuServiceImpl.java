package kr.co.menupass.commu.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.menupass.common.model.dto.PageInfo;
import kr.co.menupass.common.model.dto.PageInfo2;
import kr.co.menupass.commu.dao.CommuDao;
import kr.co.menupass.commu.dto.Commu;

@Service
public class CommuServiceImpl implements CommuService {

	@Autowired
	private CommuDao commuDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount(String searchTxt) {
		return commuDao.selectListCount(sqlSession, searchTxt);
	}
	
	@Override
	public List<Commu> selectListAll(PageInfo2 pi, String searchTxt) {
		return commuDao.selectListAll(sqlSession, pi, searchTxt);
	}
	
	@Override
	public int insertBoard(Commu co) {
		return commuDao.insertBoard(sqlSession, co);
	}
	
	@Override
	public Commu detailBoard(int c_board_No) {
		return commuDao.detailBoard(sqlSession, c_board_No);
	}
	@Override
	public int countBoard(Commu co) {
		return commuDao.countBoard(sqlSession, co);
}
	
	@Override
	public int updateBoard(Commu co) {
		return commuDao.updateBoard(sqlSession, co);
	}
	@Override
	public int deleteBoard(Commu co) {
		return commuDao.deleteBoard(sqlSession, co);
	}
	
	@Override
	public int updateUploadFree(Commu co) {
		return commuDao.updateUploadFree(sqlSession, co);
		
	}
}